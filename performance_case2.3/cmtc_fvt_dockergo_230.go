/*
Copyright (C) BABEC. All rights reserved.
Copyright (C) THL A29 Limited, a Tencent company. All rights reserved.

SPDX-License-Identifier: Apache-2.0
*/

package main

import (
	"fmt"
	"log"
	"math/rand"
	"strconv"
	"strings"
	"encoding/json"
	"time"
	"chainmaker.org/chainmaker/contract-sdk-go/v2/pb/protogo"
	"chainmaker.org/chainmaker/contract-sdk-go/v2/sandbox"
	"chainmaker.org/chainmaker/contract-sdk-go/v2/sdk"
	vmPb "chainmaker.org/chainmaker/pb-go/v2/vm"
)

const VERSION = "1.0"

type TestContract struct {
}

func (t *TestContract) InitContract() protogo.Response {
	return sdk.Success([]byte("Init Success"))
}

func (t *TestContract) UpgradeContract() protogo.Response {
	return sdk.Success([]byte("Upgrade success"))
}

func (t *TestContract) InvokeContract(method string) protogo.Response {

	switch method {
	//********** Common Info Display **********
	case "get_version":
		return t.get_version()
	case "display":
		return t.display()

//********** Positive Scenario FVT **********
	// CrossCntract	Test
	case "cross_contract":
		return t.cross_contract()
	case "call_self":
		return t.call_self()

	// Event Test
	case "event_test_set":
		return t.event_test_set()
	case "event_test_get":
		return t.event_test_get()
	case "event_test_set_no_log":
		return t.event_test_set_no_log()
	case "event_test_get_no_log":
		return t.event_test_get_no_log()
	// KvIterator Test
	case "kv_iterator":
		return t.kv_iterator()
	// KeyHistoryIterator
	case "key_history_iter":
		return t.key_history_iter()

	// CacheTest
	case "state_test_incache_needquery":
		return t.state_test_cache_needquery()
	case "state_test_cache_samekey":
		return t.state_test_cache_samekey()
	case "StateTestInCache_DiffKey":
		return t.state_test_cache_diffkey()
	case "query":
		return t.query()

	// CommonTest
	case "loop_test":
		return t.loop_test()
	case "increase":
		return t.increase()

	// TODO: 添加权限校验合约


	// Calc_json
	case "calc_test":
		return t.calc_test()
	case "get_calc":
		return t.get_calc()

	// Storemap
	case "construct_data":
		return t.construct_data()
	case "set_with_deep":
		return t.set_with_deep()
	case "get_with_deep":
		return t.get_with_deep()
	case "del_with_deep":
		return t.del_with_deep()
	case "exist_with_deep":
		return t.exist_with_deep()

	//********** Negative Scenario FVT **********
	//ErrorRollback Test
	case "error_rollback":
		return t.error_rollback()
	//	Random Test
	case "random_timeout":
		return t.random_timeout()
	case "put_state_random":
		return t.put_state_random()
	// TimeSleep Test
	case "overflow":
		return t.overflow()
	case "time_to_sleep":
		return t.time_to_sleep()
	case "timesleep_and_putstate":
		return t.timesleep_and_putstate()
	case "out_of_range":
		return t.out_of_range()

	default:
		msg := fmt.Sprintf("unknown method")
		return sdk.Error(msg)
	}
}

func (f *TestContract) get_version() protogo.Response {
	return sdk.Success([]byte("[dockergotest-fvt][get_version]GetVersion: " + VERSION))
}

func (t *TestContract) display() protogo.Response {
	return sdk.Success([]byte("display successful"))
}

//****************************** Positive Scenario FVT *****************************
// ------------------------------CrossCntractTest--------------------------------
func (t *TestContract) cross_contract() protogo.Response {

	args := sdk.Instance.GetArgs()

	contractName := string(args["contract_name"])
	contractVersion := string(args["contract_version"])
	calledMethod := string(args["contract_method"])

	crossContractArgs := make(map[string][]byte)
	crossContractArgs["method"] = []byte(calledMethod)

	// response could be correct or error
	response := sdk.Instance.CallContract(contractName, contractVersion, crossContractArgs)
	sdk.Instance.EmitEvent("[dockergotest-fvt]cross contract", []string{"[dockergotest-fvt]cross contract success"})
	return response
}

func (t *TestContract) call_self() protogo.Response {

	sdk.Instance.Infof("testing call self")

	contractName := "cmtc_fvt_dockergo_223"
	contractVersion := "1.0.0"

	crossContractArgs := make(map[string][]byte)
	crossContractArgs["method"] = []byte("cross_contract_self")

	response := sdk.Instance.CallContract(contractName, contractVersion, crossContractArgs)

	return response
}

// ------------------------------EventTest--------------------------------
func (t *TestContract) event_test_set() protogo.Response {
	args := sdk.Instance.GetArgs()
	sdk.Instance.Infof("[dockergotest-fvt][event_test_set] ========================================start")
	sdk.Instance.Infof("[dockergotest-fvt] input func: event_test_set")

	key := string(args["key"])
	field := string(args["field"])
	value := string(args["value"])

	sdk.Instance.Infof("[dockergotest-fvt] change event_test_set[key]: " + key)
	sdk.Instance.Infof("[dockergotest-fvt] change event_test_set[field]: " + field)
	sdk.Instance.Infof("[dockergotest-fvt] change event_test_set[value]: " + value)
	err := sdk.Instance.PutState(key, field, value)
	if err != nil {
		sdk.Error("[dockergotest-fvt][event_test_set]put fail")
	}
	sdk.Instance.Infof("[dockergotest-fvt] PutState: key=" + key + ",name=" + field + ",value=" + value)
	value_list := strings.Split(value, "#")
	sdk.Instance.EmitEvent(key, value_list)
	sdk.Instance.Infof("[dockergotest-fvt] ========================================end")
	return sdk.Success([]byte("finish [dockergotest-fvt]event_test_set"))
}

//export event_test_get
func (t *TestContract) event_test_get() protogo.Response {

	args := sdk.Instance.GetArgs()
	sdk.Instance.Infof("[dockergotest-fvt][event_test_get] ========================================start")
	sdk.Instance.Infof("[dockergotest-fvt] input func: event_test_get")

	key := string(args["key"])
	field := string(args["field"])

	sdk.Instance.Infof("[dockergotest-fvt] change event_test_set[key]: " + key)
	sdk.Instance.Infof("[dockergotest-fvt] change event_test_set[field]: " + field)
	value, err := sdk.Instance.GetState(key, field)
	if err != nil {
		sdk.Instance.Infof("[dockergotest-fvt] GetState: key=" + key + ",field=" + field + ",result:" + value)
	}

	value_list := strings.Split(field, "#")
	sdk.Instance.EmitEvent(key, value_list)
	sdk.Instance.Infof("[dockergotest-fvt] change event_test_get[value]: " + value)
	sdk.Instance.Infof("[dockergotest-fvt] ========================================end")
	return sdk.Success([]byte(value))
}


//export event_test_set_no_log
func (t *TestContract) event_test_set_no_log() protogo.Response {
	args := sdk.Instance.GetArgs()
	key := string(args["key"])
	field := string(args["field"])
	value := string(args["value"])
	sdk.Instance.PutState(key, field, value)
	value_list := strings.Split(value, "#")
	sdk.Instance.EmitEvent(key, value_list)
	return sdk.Success([]byte("finish event_test_set"))
}

//export event_test_get_no_log
func (t *TestContract) event_test_get_no_log() protogo.Response {
	args := sdk.Instance.GetArgs()
	key := string(args["key"])
	field := string(args["field"])
	value, _ := sdk.Instance.GetState(key, field)
	value_list := strings.Split(field, "#")
	sdk.Instance.EmitEvent(key, value_list)
	return sdk.Success([]byte(value))
}

// ------------------------------IterTest--------------------------------
func (t *TestContract) key_history_iter() protogo.Response {
	sdk.Instance.Infof("===Key History Iter START===")
	args := sdk.Instance.GetArgs()
	key := string(args["key"])
	field := string(args["field"])

	iter, err := sdk.Instance.NewHistoryKvIterForKey(key, field)
	if err != nil {
		msg := "NewHistoryIterForKey failed"
		sdk.Instance.Infof(msg)
		return sdk.Error(msg)
	}

	sdk.Instance.Infof("[dockergotest-fvt][key_history_iter]===create iter success===")

	count := 0
	for iter.HasNext() {
		sdk.Instance.Infof("HasNext")
		count++
		km, err := iter.Next()
		if err != nil {
			msg := "[dockergotest-fvt][key_history_iter]iterator failed to get the next element"
			sdk.Instance.Infof(msg)
			return sdk.Error(msg)
		}

		sdk.Instance.Infof(fmt.Sprintf("=== Data History [%d] Info:", count))
		sdk.Instance.Infof(fmt.Sprintf("=== Key: [%s]", km.Key))
		sdk.Instance.Infof(fmt.Sprintf("=== Field: [%s]", km.Field))
		sdk.Instance.Infof(fmt.Sprintf("=== Value: [%s]", km.Value))
		sdk.Instance.Infof(fmt.Sprintf("=== TxId: [%s]", km.TxId))
		sdk.Instance.Infof(fmt.Sprintf("=== BlockHeight: [%d]", km.BlockHeight))
		sdk.Instance.Infof(fmt.Sprintf("=== IsDelete: [%t]", km.IsDelete))
		sdk.Instance.Infof(fmt.Sprintf("=== Timestamp: [%s]", km.Timestamp))
	}

	closed, err := iter.Close()
	if !closed || err != nil {
		msg := fmt.Sprintf("iterator close failed, %s", err.Error())
		sdk.Instance.Infof(msg)
		return sdk.Error(msg)
	}
	sdk.Instance.Infof("[dockergotest-fvt][key_history_iter]===iter close success===")

	sdk.Instance.Infof("[dockergotest-fvt][key_history_iter]===Key History Iter END===")

	return sdk.Success([]byte("get key history successfully"))
}



// kvIterator 前置数据
/*
	| Key   | Field   | Value |
	| ---   | ---     | ---   |
	| key1  | field1  | val   |
	| key1  | field2  | val   |
	| key1  | field23 | val   |
	| ey1   | field3  | val   |
	| key2  | field1  | val   |
	| key3  | field2  | val   |
	| key33 | field2  | val   |
	| key4  | field3  | val   |
*/
func (t *TestContract) kv_iterator() protogo.Response {
	sdk.Instance.Infof("===construct START===")
	dataList := []struct {
		key   string
		field string
		value string
	}{
		{key: "key1", field: "field1", value: "val"},
		{key: "key1", field: "field2", value: "val"},
		{key: "key1", field: "field23", value: "val"},
		{key: "key1", field: "field3", value: "val"},
		{key: "key2", field: "field1", value: "val"},
		{key: "key3", field: "field2", value: "val"},
		{key: "key33", field: "field2", value: "val"},
		{key: "key33", field: "field2", value: "val"},
		{key: "key4", field: "field3", value: "val"},
	}

	for _, data := range dataList {
		err := sdk.Instance.PutState(data.key, data.field, data.value)
		if err != nil {
			msg := fmt.Sprintf("constructData failed, %s", err.Error())
			sdk.Instance.Infof(msg)
			return sdk.Error(msg)
		}
	}
	sdk.Instance.Infof("[dockergotest-fvt]===construct END===")

	sdk.Instance.Infof("[dockergotest-fvt]===kvIterator START===")
	iteratorList := make([]sdk.ResultSetKV, 4)

	// 能查询出 key2, key3, key33 三条数据
	iterator, err := sdk.Instance.NewIterator("key2", "key4")
	if err != nil {
		msg := "NewIterator failed"
		sdk.Instance.Infof(msg)
		return sdk.Error(msg)
	}
	iteratorList[0] = iterator

	// 能查询出 field1, field2, field23 三条数据
	iteratorWithField, err := sdk.Instance.NewIteratorWithField("key1", "field1", "field3")
	if err != nil {
		// msg := "create with " + string(key1) + string(field1) + string(field3) + " failed"
		msg := "create with " + "key1" + "field1" + "field3" + " failed"
		sdk.Instance.Infof(msg)
		return sdk.Error(msg)
	}
	iteratorList[1] = iteratorWithField

	// 能查询出 key3, key33 两条数据
	preWithKeyIterator, err := sdk.Instance.NewIteratorPrefixWithKey("key3")
	if err != nil {
		msg := "NewIteratorPrefixWithKey failed"
		sdk.Instance.Infof(msg)
		return sdk.Error(msg)
	}
	iteratorList[2] = preWithKeyIterator

	// 能查询出 field2, field23 三条数据
	preWithKeyFieldIterator, err := sdk.Instance.NewIteratorPrefixWithKeyField("key1", "field2")
	if err != nil {
		msg := "NewIteratorPrefixWithKeyField failed"
		sdk.Instance.Infof(msg)
		return sdk.Error(msg)
	}
	iteratorList[3] = preWithKeyFieldIterator

	for index, iter := range iteratorList {
		index++
		sdk.Instance.Infof(fmt.Sprintf("===iterator %d START===", index))
		for iter.HasNext() {
			sdk.Instance.Infof("HasNext Success")
			key, field, value, err := iter.Next()
			if err != nil {
				msg := "iterator failed to get the next element"
				sdk.Instance.Infof(msg)
				return sdk.Error(msg)
			}

			sdk.Instance.Infof(fmt.Sprintf("===[key: %s]===", key))
			sdk.Instance.Infof(fmt.Sprintf("===[field: %s]===", field))
			sdk.Instance.Infof(fmt.Sprintf("===[value: %s]===", value))
		}

		closed, err := iter.Close()
		if !closed || err != nil {
			msg := fmt.Sprintf("iterator %d close failed, %s", index, err.Error())
			sdk.Instance.Infof(msg)
			return sdk.Error(msg)
		}
		sdk.Instance.Infof(fmt.Sprintf("===iterator %d END===", index))
	}
	sdk.Instance.Infof("===kvIterator END===")

	return sdk.Success([]byte("SUCCESS"))
}


//------------------------------------MultipleOpsInOneTx_CacheTest-------------------------
func (t *TestContract) state_test_cache_needquery() protogo.Response {
	/*
		场景1：直接调用doublePutState方法，分别查询dockergotest_key01和dockergotest_key01的值
		场景2：跨合约调用doublePutState方法，分别跨合约调用查询dockergotest_key01和dockergotest_key01的值
		场景3：跨合约调用doublePutState方法，分别直接查询dockergotest_key01和dockergotest_key01的值
	*/

	args := sdk.Instance.GetArgs()
	value01 := string(args["value01"])
	value02 := string(args["value02"])

	err := sdk.Instance.PutState("dockergotest_key01", "dockergotest_field01", value01)
	if err != nil {
		return sdk.Error(err.Error())
	}

	err = sdk.Instance.PutState("dockergotest_key02", "dockergotest_field02", value02)
	if err != nil {
		return sdk.Error(err.Error())
	}

	sdk.Instance.Infof("[dockergotest-fvt][state_test_cache_needquery]PutState Success")
	return sdk.Success([]byte("PutState successfully"))

}

func (t *TestContract) state_test_cache_samekey() protogo.Response {
	args := sdk.Instance.GetArgs()
	value01 := string(args["value01"])
	value02 := string(args["value02"])

	err := sdk.Instance.PutState("dockergotest_key", "dockergotest_field", value01)
	if err != nil {
		return sdk.Error(err.Error())
	}

	res1, err := sdk.Instance.GetState("dockergotest_key", "dockergotest_field")
	if err != nil {
		return sdk.Error(err.Error())
	}

	err = sdk.Instance.PutState("dockergotest_key", "dockergotest_field", value02)
	if err != nil {
		return sdk.Error(err.Error())
	}

	res2, err := sdk.Instance.GetState("dockergotest_key", "dockergotest_field")
	if err != nil {
		return sdk.Error(err.Error())
	}
	msg := fmt.Sprintf("[dockergotest-fvt][1st:putstate_result]:%s; [2nd:putstate_result]:%s", res1, res2)
	sdk.Instance.Infof(msg)
	return sdk.Success([]byte(msg))
}

func (t *TestContract) state_test_cache_diffkey() protogo.Response {
	/*
		场景1：直接调用doublePutState方法，分别查询dockergotest_key01和dockergotest_key01的值
		场景2：跨合约调用doublePutState方法，分别跨合约调用查询dockergotest_key01和dockergotest_key01的值
		场景3：跨合约调用doublePutState方法，分别直接查询dockergotest_key01和dockergotest_key01的值
	*/

	args := sdk.Instance.GetArgs()
	value01 := string(args["value01"])
	value02 := string(args["value02"])

	err := sdk.Instance.PutState("dockergotest_key01", "dockergotest_field01", value01)
	if err != nil {
		return sdk.Error(err.Error())
	}

	err = sdk.Instance.PutState("dockergotest_key02", "dockergotest_field02", value02)
	if err != nil {
		return sdk.Error(err.Error())
	}

	res1, err := sdk.Instance.GetState("dockergotest_key01", "dockergotest_field01")
	if err != nil {
		return sdk.Error(err.Error())
	}

	res2, err := sdk.Instance.GetState("dockergotest_key02", "dockergotest_field02")
	if err != nil {
		return sdk.Error(err.Error())
	}

	msg := fmt.Sprintf("[1st:putstate_result]:%s; [2nd:putstate_result]:%s", res1, res2)
	sdk.Instance.Infof(msg)
	return sdk.Success([]byte(msg))
}

func (t *TestContract) query() protogo.Response {
	args := sdk.Instance.GetArgs()
	key := string(args["key"])
	field := string(args["field"])

	res, err := sdk.Instance.GetState(key, field)
	if err != nil {
		return sdk.Error("[dockergotest-fvt][query]fail")
	}
	return sdk.Success([]byte(res))
}


// ---------------------------------
func (t *TestContract) loop_test() protogo.Response {
	args := sdk.Instance.GetArgs()

	sdk.Instance.Infof("[dockergotest-fvt][loop_test]")
	loopnum_str := string(args["loop_num"])
	iloopnum, _ := strconv.Atoi(loopnum_str)
	for i := iloopnum; i > 1; i-- {
		sdk.Instance.Infof("[dockergotest-fvt][loop_test] change loop_test[i]: " + strconv.FormatInt(int64(i), 10))
		sdk.Instance.PutState("dockergotest", "loopnum", strconv.FormatInt(int64(i), 10))
	}
	sdk.Instance.Infof("finish loop")
	return sdk.Success([]byte("finish loop"))
}

func (t *TestContract) increase() protogo.Response {
	sdk.Instance.Infof("call increase")

	heartbeatInt := 0
	if heartbeatString, err := sdk.Instance.GetState("Counter", "heartbeat"); err != nil {
		heartbeatInt = 1
		sdk.Instance.Infof("[dockergotest][fvt-Increase]call increase, put state from empty")
		sdk.Instance.PutState("Counter", "heartbeat", strconv.Itoa(heartbeatInt))
	} else {
		heartbeatInt, _ = strconv.Atoi(heartbeatString)
		heartbeatInt++
		sdk.Instance.Infof("[dockergotest-fvt][increase]call increase, put state from exist")
		sdk.Instance.PutState("Counter", "heartbeat", strconv.Itoa(heartbeatInt))
	}

	var msg = []string{"heartbeat", strconv.Itoa(heartbeatInt)}
	sdk.Instance.EmitEvent("[dockergotest-fvt][increase]Counter", msg)
	return sdk.Success([]byte(strconv.Itoa(heartbeatInt)))
}

// ---------------------------------CalcTest--------------------------------

func (t *TestContract) calc_test() protogo.Response {
	sdk.Instance.Infof("[dockergotest][fvt-CalcTest] input func: calc_json")
	args := sdk.Instance.GetArgs()
	func_name := string(args["func_name"])
	data1 := string(args["data1"])
	data2 := string(args["data1"])

	sdk.Instance.Infof("[dockergotest-fvt][calc_test]:func_name" + func_name)
	sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data1-" + data1)
	sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data2- " + data2)

	idata1, _ := strconv.Atoi(data1)
	idata2, _ := strconv.Atoi(data2)

	var result_str string
	var result int
	status := false
	if func_name == "add" {
		result = idata1 + idata2
		result_str = strconv.FormatInt(int64(result), 10)
		status = true
	} else if func_name == "sub" {
		result = idata1 - idata2
		result_str = strconv.FormatInt(int64(result), 10)
		status = true
	} else if func_name == "mul" {
		result = idata1 * idata2
		result_str = strconv.FormatInt(int64(result), 10)
		status = true
	} else if func_name == "div" {
		result = idata1 / idata2
		result_str = strconv.FormatInt(int64(result), 10)
		status = true
	} else if func_name == "set_data" {
		data3 := string(args["data3"])
		data4 := string(args["data4"])
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data3-" + data3)
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data4- " + data4)
		sdk.Instance.PutState("dockergotest", data3, data4)
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]func_name result: " + result_str)
		status = true
	} else if func_name == "failure" {
		data3 := string(args["data3"])
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data3-" + data3)
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]func_name failure set result: " + data3)
		sdk.Instance.PutState("dockergotest", func_name, data3)
		sdk.Error("[dockergotest-fvt][calc_test]failure error")
	} else if func_name == "failure_succes" {
		data3 := string(args["data3"])
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data3-" + data3)
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]func_name failure set result: " + data3)
		sdk.Instance.PutState("dockergotest", func_name, data3)
		sdk.Success([]byte("[dockergotest-fvt][calc_test]failure success"))
	} else if func_name == "delete" {
		data3 := string(args["data3"])
		sdk.Instance.Infof("[dockergotest-fvt][calc_test]:data3-" + data3)
		sdk.Instance.Infof("[dockergotest-fvt][calc_test] func_name: delete-" + data3)
		sdk.Instance.DelState("dockergotest", data3)
		status = true
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][calc_test] panic test")
		sdk.Instance.PutState("dockergotest", func_name, "panic")
		panic("[dockergotest]test panic !!!")
	}
	if status {
		sdk.Instance.PutState("dockergotest", func_name, result_str)
		sdk.Instance.Infof("[dockergotest-fvt] calc_json[func_name] result: " + result_str)
		sdk.Success([]byte("ok"))
	}
	return sdk.Success([]byte("ok"))
}


func (t *TestContract) get_calc() protogo.Response {
	args := sdk.Instance.GetArgs()
	sdk.Instance.Infof("[dockergotest-fvt][fvt-GetCalc]input func: get_json")
	func_name := string(args["func_name"])
	sdk.Instance.Infof("[dockergotest-fvt] get_calc[func_name]: " + func_name)

	result, _ := sdk.Instance.GetState("dockergotest", func_name)
	sdk.Instance.Infof("[dockergotest-fvt] calc_json[func_name] result: " + result)
	return sdk.Success([]byte(result))
}


func (t *TestContract) overflow() protogo.Response {
	NumA := int64(9223372036854775807)
	NumB := int32(NumA)

	strA := strconv.Itoa(int(NumA))
	strB := strconv.Itoa(int(NumB))

	sdk.Instance.Infof("[dockergotest-fvt][overflow]Int64 convert to Int32 result: " + strA + " to " + strB)
	return sdk.Success([]byte("overflow testing Pass"))
}

func (f *TestContract) error_rollback() protogo.Response {
	args := sdk.Instance.GetArgs()

	key := string(args["key"])
	field := string(args["field"])
	newPutValue := string(args["value"])

	txIdInfo, err := sdk.Instance.GetTxId()
	txTimestamp, errTime := sdk.Instance.GetTxTimeStamp()

	if err != nil || errTime != nil{
		return sdk.Error(err.Error())
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][error_rollback] txid:" + txIdInfo + "(timestamp:" + txTimestamp +")")
	}

	result1, err := sdk.Instance.GetState(key, field)
	if err != nil {
		return sdk.Error(err.Error())
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][error_rollback] Step1: get current result: " + result1)
	}
	err = sdk.Instance.PutState(key, field, newPutValue)

	if err != nil {
		return sdk.Error(err.Error())
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][error_rollback] Step2:put new value: " + newPutValue)
	}

	result2, err := sdk.Instance.GetState(key, field)

	if err != nil {
		return sdk.Error(err.Error())
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][error_rollback] Step3: get state after setting new:" + result2)
	}

	return sdk.Error("[dockergotest-fvt][error_rollback]: trigger error to test rollback")
}


func (t *TestContract) random_timeout() protogo.Response {
	args := sdk.Instance.GetArgs()

	testKey := string(args["key"])
	testField := string(args["field"])
	testValue := string(args["value"])

	txIdInfo, err := sdk.Instance.GetTxId()
	txTimestamp, errTime := sdk.Instance.GetTxTimeStamp()

	if err != nil || errTime != nil{
		return sdk.Error(err.Error())
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][random_timeout] txid:" + txIdInfo + "(timestamp:" + txTimestamp +")")
	}

	rand.Seed(time.Now().Unix())
	randomdifftime := time.Duration(rand.Intn(3) * 1000 + 7500) * time.Millisecond
	time.Sleep( randomdifftime)
	err = sdk.Instance.PutState(testKey, testField, testValue)
	if err != nil {
		return sdk.Error(err.Error())
	}

	return sdk.Success([]byte("[dockergotest-fvt][random_timeout]: put state successfully: " + testValue))
}

func (f *TestContract) put_state_random() protogo.Response {
	args := sdk.Instance.GetArgs()

	testKey := string(args["key"])
	testField := string(args["field"])

	txIdInfo, err := sdk.Instance.GetTxId()
	txTimestamp, errTime := sdk.Instance.GetTxTimeStamp()

	if err != nil || errTime != nil{
		return sdk.Error(err.Error())
	} else {
		sdk.Instance.Infof("[dockergotest-fvt][put_state_random] txid:" + txIdInfo + "(timestamp:" + txTimestamp +")")
	}

	rand.Seed(time.Now().UnixNano())
	testvalue := string(rand.Intn(10000000))

	err = sdk.Instance.PutState(testKey, testField, testvalue)
	if err != nil {
		return sdk.Error(err.Error())
	}

	return sdk.Success([]byte("[dockergotest-fvt][put_state_random]: put state successfully: " + testvalue))
}


func (t *TestContract) time_to_sleep() protogo.Response {
	/*
	params: timeToSleep, 单位：ms
	 */
	args := sdk.Instance.GetArgs()
	getTimeOutParam := string(args["time_to_sleep"])
	sleepTimeInt, err := strconv.ParseInt(getTimeOutParam, 10, 64)

	if err != nil {
		return sdk.Error("parse time out param failed")
	}

	sleepDuration := time.Duration(sleepTimeInt) * time.Millisecond
	time.Sleep( sleepDuration )
	msg := fmt.Sprintf("[dockergotest-fvt][time_to_sleep]sleep %s done", sleepDuration)
	sdk.Instance.Infof(msg)
	return sdk.Success([]byte("success finish timeout"))
}

func (t *TestContract) timesleep_and_putstate() protogo.Response {
	args := sdk.Instance.GetArgs()

	getKey := string(args["key"])
	getValue := string(args["value"])
	getTimeOutParam := string(args["time_to_sleep"])

	sleepTimeInt, err := strconv.ParseInt(getTimeOutParam, 10, 64)
	if err != nil {
		return sdk.Error("parse time out param failed")
	}
	sleepDuration := time.Duration(sleepTimeInt) * time.Millisecond
	time.Sleep( sleepDuration )

	err = sdk.Instance.PutStateFromKey(getKey, getValue)
	if err != nil {
		return sdk.Error("[dockergotest-fvt][timesleep_and_putstate]put state failed")
	}

	return sdk.Success([]byte("success time sleep and then put state"))
}


func (t *TestContract) out_of_range() protogo.Response {
	var group []string
	group[0] = "abc"
	fmt.Println(group[0])
	sdk.Instance.Infof("[dockergotest-fvt][out_of_range]success")
	return sdk.Success([]byte("exit out of range"))
}

// constructData 提供Kv迭代器的测试数据
/*
	| Key   | Field   | Value |
	| ---   | ---     | ---   |
	| key1  | field1  | val   |
	| key1  | field2  | val   |
	| key1  | field23 | val   |
	| ey1   | field3  | val   |
	| key2  | field1  | val   |
	| key3  | field2  | val   |
	| key33 | field2  | val   |
	| key4  | field3  | val   |
*/
func (t *TestContract) construct_data() protogo.Response {
	dataList := []struct {
		key   string
		field string
		value string
	}{
		{key: "key1", field: "field1", value: "val"},
		{key: "key1", field: "field2", value: "val"},
		{key: "key1", field: "field23", value: "val"},
		{key: "key1", field: "field3", value: "val"},
		{key: "key2", field: "field1", value: "val"},
		{key: "key3", field: "field2", value: "val"},
		{key: "key33", field: "field2", value: "val"},
		{key: "key33", field: "field2", value: "val"},
		{key: "key4", field: "field3", value: "val"},
	}

	for _, data := range dataList {
		err := sdk.Instance.PutState(data.key, data.field, data.value)
		if err != nil {
			msg := fmt.Sprintf("constructData failed, %s", err.Error())
			sdk.Instance.Infof(msg)
			return sdk.Error(msg)
		}
	}

	return sdk.Success([]byte("construct success!"))
}


// GetBatchState
/*
	| Key   | Field   | Value |
	| ---   | ---     | ---   |
	| key1  | field1  | val   |
	| key1  | field2  | val   |
	| key1  | field23 | val   |
	| ey1   | field3  | val   |
	| key2  | field1  | val   |
	| key3  | field2  | val   |
	| key33 | field2  | val   |
	| key4  | field3  | val   |
*/
func (t *TestContract) get_batch_state() protogo.Response {
	sdk.Instance.Infof("===construct START===")
	dataList := []struct {
		key   string
		field string
		value string
	}{
		{key: "key1", field: "field11", value: "key1-field11"},
		{key: "key1", field: "field12", value: "key1-field12"},
		{key: "key1", field: "field13", value: "key1-field13"},
		{key: "key1", field: "field14", value: "key1-field14"},
		{key: "key2", field: "field21", value: "key2-field21"},
		{key: "key3", field: "field31", value: "key3-field31"},
		{key: "key33", field: "field2", value: "key33-field2"},
		{key: "key33", field: "field2", value: "key33-field2"},
		{key: "key4", field: "field3", value: "key4-field3"},
	}

	for _, data := range dataList {
		err := sdk.Instance.PutState(data.key, data.field, data.value)
		if err != nil {
			msg := fmt.Sprintf("constructData failed, %s", err.Error())
			sdk.Instance.Infof(msg)
			return sdk.Error(msg)
		}
	}
	sdk.Instance.Infof("===construct END===")

	batchKeys := []*vmPb.BatchKey{
		{"key1", "field1", nil, ""},
		{"key1", "field2", nil, ""},
		{"key3", "field2", nil, ""},
		{"key4", "field2", nil, ""},
	}
	gotValues, err := sdk.Instance.GetBatchState(batchKeys)
	if err != nil {
		msg := fmt.Sprintf("constructData failed, %s", err.Error())
		return sdk.Error(msg)
	}
	result := fmt.Sprintf("%v", gotValues)

	return sdk.Success([]byte(result))
}


// 批量getState
func (f *TestContract) get_batch_state_v2() protogo.Response {
	params := sdk.Instance.GetArgs()
	items := string(params["items"])
	batchKeys := []*vmPb.BatchKey{}
	itemArray := []string{}
	err := json.Unmarshal([]byte(items), &itemArray)
	if err != nil {
		return sdk.Error("json unmarshal error")
	}
	for _, item := range itemArray {
		keyField := strings.Split(item, ".")
		key := keyField[0]
		filed := keyField[1]
		batchKeys = append(batchKeys, &vmPb.BatchKey{key, filed, nil, ""})
	}
	sdk.Instance.Warnf("batchKeys: %v", batchKeys)

	gotValues, err := sdk.Instance.GetBatchState(batchKeys)
	if err != nil {
		msg := fmt.Sprintf("constructData failed, %s")
		return sdk.Error(msg)
	}
	result := fmt.Sprintf("%v", gotValues)
	return sdk.Success([]byte(result))
}

func (t *TestContract) div_zero() protogo.Response {

	args := sdk.Instance.GetArgs()

	NumA, errA := strconv.Atoi(string(args["arg1"]))
	NumB, errB := strconv.Atoi(string(args["arg2"]))

	if errA == nil && errB == nil {
		result := NumA / NumB
		strc := strconv.Itoa(result)
		sdk.Instance.Infof("cal Div success")
		return sdk.Success([]byte(string(args["arg1"]) + "/" + string(args["arg2"]) + "=" + strc))
	} else {
		sdk.Instance.Infof(("cal Div failed"))
		return sdk.Error("incorrect paramaters")
	}
}

// -----------------------------StoreMap Contract-------------------------
/*
合约各方法调用的输入参数
storemapname, deep, key1, key2, key3, key4, key5, value
*/

func (f *TestContract) set_with_deep() protogo.Response {
	var err error
	var storeMap *sdk.StoreMap
	var deep int

	args := sdk.Instance.GetArgs()
	storeMapName := string(args["storemapname"])
	value, ok := args["value"]
	if !ok {
		return sdk.Error("value can not be empty")
	}

	deepIn, ok := args["deep"]
	if !ok {
		return sdk.Error("deep can not be empty")
	}

	deep, err = strconv.Atoi(string(deepIn))

	if err != nil {
		return sdk.Error("convert to int error")
	}

	storeMap, err = sdk.NewStoreMap(storeMapName, int64(deep))
	if err != nil {
		return sdk.Error(err.Error())
	}

	keys := generateKeys()
	key := keys[int64(deep)]

	err = storeMap.Set(key, value)
	if err != nil {
		sdk.Instance.Infof("[dockergotest-fvt][storemap-Set_deep1]failed")
		return sdk.Error("[dockergotest-fvt][storemap-Set_deep1]" + err.Error())
	}
	return sdk.Success([]byte("[dockergotest-fvt][storemap-Set_deep1]success"))
}

func (f *TestContract) get_with_deep() protogo.Response {
	var err error
	var storeMap *sdk.StoreMap
	var deep int

	args := sdk.Instance.GetArgs()
	storeMapName := string(args["storemapname"])
	deepIn, ok := args["deep"]
	if !ok {
		return sdk.Error("deep can not be empty")
	}

	deep, err = strconv.Atoi(string(deepIn))

	if err != nil {
		return sdk.Error("convert to int error")
	}

	storeMap, err = sdk.NewStoreMap(storeMapName, int64(deep))
	if err != nil {
		return sdk.Error(err.Error())
	}

	keys := generateKeys()
	key := keys[int64(deep)]

	getResult, err := storeMap.Get(key)
	if err != nil {
		sdk.Instance.Infof("[dockergotest-fvt][storemap-Get_deep]failed")
		return sdk.Error("[dockergotest-fvt][storemap-Get_deep]" + err.Error())
	}
	// 	sdk.Success([]byte("[dockergotest][storemap-Get_deep1]success"))
	return sdk.Success([]byte(getResult))

}

func (f *TestContract) del_with_deep() protogo.Response {
	var err error
	var storeMap *sdk.StoreMap
	var deep int

	args := sdk.Instance.GetArgs()
	storeMapName := string(args["storemapname"])
	deepIn, ok := args["deep"]
	if !ok {
		return sdk.Error("deep can not be empty")
	}

	deep, err = strconv.Atoi(string(deepIn))

	if err != nil {
		return sdk.Error("convert to int error")
	}

	storeMap, err = sdk.NewStoreMap(storeMapName, int64(deep))
	if err != nil {
		return sdk.Error(err.Error())
	}

	keys := generateKeys()
	key := keys[int64(deep)]

	err = storeMap.Del(key)
	if err != nil {
		sdk.Instance.Infof("[dockergotest-fvt][storemap-Del_deep]failed")
		return sdk.Error("[dockergotest-fvt][storemap-Del_deep]" + err.Error())
	}
	return sdk.Success([]byte("[dockergotest-fvt][storemap-Del_deep1]success"))
}

func (t *TestContract) exist_with_deep() protogo.Response {
	var err error
	var storeMap *sdk.StoreMap
	var deep int

	args := sdk.Instance.GetArgs()
	storeMapName := string(args["storemapname"])
	deepIn, ok := args["deep"]
	if !ok {
		return sdk.Error("deep can not be empty")
	}

	deep, err = strconv.Atoi(string(deepIn))

	if err != nil {
		return sdk.Error("convert to int error")
	}

	storeMap, err = sdk.NewStoreMap(storeMapName, int64(deep))
	if err != nil {
		return sdk.Error(err.Error())
	}

	keys := generateKeys()
	key := keys[int64(deep)]

	_, err = storeMap.Exist(key)
	if err != nil {
		sdk.Instance.Infof("[dockergotest-fvt][storemap-Exist_deep1]failed")
		return sdk.Error("[dockergotest-fvt][storemap-Exist_deep1]" + err.Error())
	}
	return sdk.Success([]byte("[dockergotest-fvt][storemap-Exist_deep1]success"))
}

func generateKeys() map[int64][]string {
	args := sdk.Instance.GetArgs()
	key1 := string(args["key1"])
	key2 := string(args["key2"])
	key3 := string(args["key3"])
	key4 := string(args["key4"])
	key5 := string(args["key5"])

	keys := make(map[int64][]string)
	keys[1] = []string{key1}
	keys[2] = []string{key1, key2}
	keys[3] = []string{key1, key2, key3}
	keys[4] = []string{key1, key2, key3, key4}
	keys[5] = []string{key1, key2, key3, key4, key5}

	return keys
}

// ----------------------------- main函数 -------------------------
func main() {
	err := sandbox.Start(new(TestContract))
	if err != nil {
		log.Fatal(err)
	}
}
