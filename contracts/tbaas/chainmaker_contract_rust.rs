/*
Copyright (C) BABEC. All rights reserved.

SPDX-License-Identifier: Apache-2.0

*/
/*
存证合约示例
export method:
    init_contract           初始化方法           参数：无
    upgrade                 升级                参数：无
    saveEvidence            存证保存            参数： factHash、factType、factJson
    verifyEvidence          存证校验            参数： factHash、factType
    saveContractStatus      合同状态保存        参数： factHash、factType、factStatus
    searchContractStatus    查询合同状态        参数： factHash
*/

use crate::easycodec::*;
use crate::sim_context;
use sim_context::*;

// 安装合约时会执行此方法，必须
#[no_mangle]
pub extern "C" fn init_contract() {
    sim_context::log("init_contract");
    let ctx = &mut sim_context::get_sim_context();
    // set pubkey
    sim_context::log("search pubkey");
    ctx.put_state("verify", "searchContractStatus", "0c420ec3f2d5c7eec16ccf35a82e0c3c15e040229057d80bd07eabbe7c71667d,a01d4820dff7efea39576c41ecc176a841c132bffb471a0be55185804a3f17bf".as_bytes());
}

// 升级合约时会执行此方法，必须
#[no_mangle]
pub extern "C" fn upgrade() {
    sim_context::log("upgrade success");
    let ctx = &mut sim_context::get_sim_context();
    //ctx.ok("upgrade ok".as_bytes());
    // set pubkey
    sim_context::log("search pubkey");
    ctx.put_state("verify", "searchContractStatus", "e5ccd8b3c724488d3b9f97b1c853efffa7e0c9c3ce465be5527eb0213ea744d1,ba62b258e957ad7c39105d91bd1e43e60b06b6f52c3b241c95f9b42ca55b5ac3".as_bytes());
}

#[no_mangle]
pub extern "C" fn saveEvidence() {
    // 获取上下文
    let ctx = &mut sim_context::get_sim_context();

    // 获取传入参数
    let fact_hash = ctx.arg_default_blank("factHash");
    let fact_type = ctx.arg_default_blank("factType");
    let fact_json = ctx.arg_default_blank("factJson");

    // 校验参数
    if fact_hash.len() == 0 {
        ctx.log("factHash is null");
        ctx.ok("factHash is null".as_bytes());
        return;
    }
    if fact_type.len() == 0 {
        ctx.log("factType is null");
        ctx.ok("factType is null".as_bytes());
        return;
    }

    let mut ec = EasyCodec::new();
    ec.put_string("factHash", fact_hash.as_str());
    ec.put_string("factType", fact_type.as_str());
    ec.put_string("factJson", fact_json.as_str());

    // 存储
    let is_ok = ctx.put_state(&fact_type, &fact_hash, ec.marshal().as_slice());

    if is_ok == sim_context::SUCCESS_CODE {
        let s = format!(
            "++ saveEvidence factType success, factType={}",
            fact_type.to_string()
        );
        ctx.log(&s);
        let _ = ctx.ok(s.as_bytes());
    } else {
        let s = format!(
            "++ saveEvidence factType error, factType={}",
            fact_type.to_string()
        );
        ctx.log(&s);
        let _ = ctx.error(&fact_type);
    }

    ctx.put_state("factContract", &fact_type, fact_hash.as_bytes());
}

#[no_mangle]
pub extern "C" fn verifyEvidence() {
    // 获取上下文
    let ctx = &mut sim_context::get_sim_context();

    // 获取传入参数
    let fact_hash = ctx.arg_default_blank("factHash");
    let fact_type = ctx.arg_default_blank("factType");

    // 校验参数
    if fact_hash.len() == 0 {
        ctx.log("factHash is null");
        ctx.ok("factHash is null".as_bytes());
        return;
    }
    if fact_type.len() == 0 {
        ctx.log("factType is null");
        ctx.ok("factType is null".as_bytes());
        return;
    }

    // 查询
    let (fact_vec, code) = ctx.get_state(&fact_type, &fact_hash);

    // 校验返回结果
    if code != SUCCESS_CODE {
        ctx.log("verifyEvidence get_state fail");
        ctx.error("verifyEvidence get_state fail");
        return;
    }
    if fact_vec.len() == 0 {
        ctx.log("verifyEvidence data None");
        ctx.ok("verifyEvidence data None".as_bytes());
        return;
    }
    // 反序列化
    let data = EasyCodec::unmarshal(fact_vec);
    // 打印日志
    let json_str = data.to_json();
    ctx.log(&json_str);
    // 返回查询结果
    ctx.ok(json_str.as_bytes());
}

// 合同状态保存
#[no_mangle]
pub extern "C" fn saveContractStatus() {
    // 获取上下文
    let ctx = &mut sim_context::get_sim_context();

    // 获取传入参数
    let fact_hash = ctx.arg_default_blank("factHash");
    let fact_type = ctx.arg_default_blank("factType");
    let fact_status = ctx.arg_default_blank("factStatus");

    // 校验参数
    if fact_hash.len() == 0 {
        ctx.log("fact_hash is null");
        ctx.ok("fact_hash is null".as_bytes());
        return;
    }
    if fact_type.len() == 0 {
        ctx.log("factType is null");
        ctx.ok("factType is null".as_bytes());
        return;
    }
    if fact_status.len() == 0 {
        ctx.log("fact_status is null");
        ctx.ok("fact_status is null".as_bytes());
        return;
    }

    let mut ec = EasyCodec::new();
    ec.put_string("factHash", fact_hash.as_str());
    ec.put_string("factType", fact_type.as_str());
    ec.put_string("factStatus", fact_status.as_str());

    // 存储
    let is_ok = ctx.put_state("contarctStatus", &fact_hash, ec.marshal().as_slice());

    if is_ok == sim_context::SUCCESS_CODE {
        let s = format!(
            "++ saveContractStatus factHash success, factHash={}",
            fact_hash.to_string()
        );
        ctx.log(&s);
        let _ = ctx.ok(s.as_bytes());
    } else {
        let s = format!(
            "++ saveContractStatus factHash error, factHash={}",
            fact_hash.to_string()
        );
        ctx.log(&s);
        let _ = ctx.error(&fact_type);
    }
}

// 查询合同状态
#[no_mangle]
pub extern "C" fn searchContractStatus() {
    // 获取上下文
    let ctx = &mut sim_context::get_sim_context();
    let (is_ok, msg) = verifyPubKey(ctx);
    if !is_ok {
        ctx.log(&msg);
        ctx.ok(msg.as_bytes());
        return;
    }

    // 获取传入参数
    let fact_hash = ctx.arg_default_blank("factHash");

    // 校验参数
    if fact_hash.len() == 0 {
        ctx.log("factHash is null");
        ctx.ok("factHash is null".as_bytes());
        return;
    }

    // 查询
    let (fact_vec, code) = ctx.get_state("contarctStatus", &fact_hash);

    // 校验返回结果
    if code != SUCCESS_CODE {
        ctx.log("searchContractStatus get_state fail");
        ctx.error("searchContractStatus get_state fail");
        return;
    }
    if fact_vec.len() == 0 {
        ctx.log("searchContractStatus data None");
        ctx.ok("searchContractStatus data None".as_bytes());
        return;
    }
    // 反序列化
    let data = EasyCodec::unmarshal(fact_vec);
    // 打印日志
    let json_str = data.to_json();
    ctx.log(&json_str);
    // 返回查询结果
    ctx.ok(json_str.as_bytes());
}

fn verifyPubKey(ctx: &mut SimContext) -> (bool, String) {
    let pub_key = ctx.get_sender_pub_key();
    // 查询
    let (state, code) = ctx.get_state("verify", "searchContractStatus");

    // 校验返回结果
    if code != SUCCESS_CODE {
        ctx.log("get_state fail");
        ctx.error("get_state fail");
        return (false, "get_state fail".to_string());
    }
    if state.len() == 0 {
        ctx.log("None");
        ctx.ok("".as_bytes());
        return (false, "not set pubkey".to_string());
    }

    let pub_keys = String::from_utf8(state).unwrap();

    if pub_keys.contains(pub_key.as_str()) {
        return (true, "".to_string());
    }
    return (false, "verify sender fail, pub key is ".to_string() + pub_key.as_str());
}
