#include "chainmaker/chainmaker.h"
using namespace chainmaker;
class Counter : public Contract
{
public:
    void init_contract() {}
    void upgrade() {}


    void increase()
    {
        Context *ctx = context();
        ctx->log("[ctest] function: increase");
        std::string key;
        std::string value;
        ctx->arg("key", key);
        int counter = std::stoi(key);
        EasyCodecItems *value_items;
        if (ctx->get_object("cpp_counter", &value)) {
            value_items = easy_unmarshal((byte *)value.data());
            std::string value_str = value_items->get_value("value");

            if (value_str == "") {
                value_str = "0";
            }
            counter = std::stoi(value_str, 0, 10);
            ctx->log("[ctest] get success, cpp_counter: " + value_str);
        }
        counter ++;
        value = std::to_string(counter);
        ctx->put_object("cpp_counter", value);
        ctx->log("put success:" + value);
        ctx->success(value);
        delete (value_items);
    }

    void query()
    {
        Context *ctx = context();
        ctx->log("[ctest] function: query");
        std::string value;
        ctx->get_object("cpp_counter", &value);
        EasyCodecItems *value_items;
        value_items = easy_unmarshal((byte *)value.data());
        std::string value_str = value_items->get_value("value");
        if (value_str == "") {
            value_str = "0";
        }
        int counter = std::stoi(value_str, 0, 10);
        ctx->log("[ctest] get success, cpp_counter: " + value_str);
        value = std::to_string(counter);
        ctx->log("put success:" + value);
        ctx->success(value);
        delete (value_items);
    }

    void set_store()
    {
        Context *ctx = context();
        ctx->log("[ctest] function: set_store");
        std::string key;
        std::string value;
        ctx->arg("key", key);
        ctx->arg("value", value);
        ctx->log("[ctest] key: "+key+",value:"+value);
        bool status = ctx->put_object(key, value);
        ctx->log("[ctest] put_object result: "+std::to_string(status));
        ctx->success("ok");
    }

    void get_store()
    {
        Context *ctx = context();
        ctx->log("[ctest] function: get_store");
        std::string key;
        std::string value;
        ctx->arg("key", key);
        ctx->log("[ctest] key: "+key);
        bool status = ctx->get_object(key, &value);
        // ctx->log("[ctest] get_object result: "+std::to_string(status)+",value:"+value);
        // ctx->success(value);
        EasyCodecItems *value_items;
        value_items = easy_unmarshal((byte *)value.data());
        std::string value_str = value_items->get_value("value");
        ctx->log("[ctest] get_object result: "+std::to_string(status)+",value:"+value_str);
        ctx->success(value_str);
        delete (value_items);
    }

    void upgrade_set_store()
    {
        Context *ctx = context();
        ctx->log("[ctest] function: upgrade_set_store");
        std::string key;
        std::string value;
        ctx->arg("key", key);
        ctx->arg("value", value);
        ctx->log("[ctest] key: "+key+",value:"+value);
        bool status = ctx->put_object(key, value);
        ctx->log("[ctest] put_object result: "+std::to_string(status));
        ctx->success("ok");
    }

        void upgrade_get_store()
    {
        Context *ctx = context();
        ctx->log("[ctest] function: get_store");
        std::string key;
        std::string value;
        ctx->arg("key", key);
        ctx->log("[ctest] key: "+key);
        bool status = ctx->get_object(key, &value);
        // ctx->log("[ctest] get_object result: "+std::to_string(status)+",value:"+value);
        // ctx->success(value);
        EasyCodecItems *value_items;
        value_items = easy_unmarshal((byte *)value.data());
        std::string value_str = value_items->get_value("value");
        ctx->log("[ctest] get_object result: "+std::to_string(status)+",value:"+value_str);
        ctx->success(value_str);
        delete (value_items);
    }



    void set_store_no_log()
    {
        Context *ctx = context();
        std::string key;
        std::string value;
        ctx->arg("key", key);
        ctx->arg("value", value);
        ctx->log("[ctest] key: "+key+",value:"+value);
        ctx->put_object(key, value);
        // bool status = true;
        // ctx->log("[ctest] put_object result: "+std::to_string(status));
        ctx->success("ok");
    }

    void get_store_no_log()
    {
        Context *ctx = context();
        std::string key;
        std::string value;
        ctx->arg("key", key);
        // ctx->log("[ctest] key: "+key);
        ctx->get_object(key, &value);
        EasyCodecItems *value_items;
        value_items = easy_unmarshal((byte *)value.data());
        std::string value_str = value_items->get_value("value");
        ctx->success(value_str);
        delete (value_items);
    }


    void save()
    {
        Context *ctx = context();

        std::string file_hash;
        std::string file_name;
        std::string tx_id;

        ctx->arg("file_hash", file_hash);
        ctx->arg("file_name", file_name);
        ctx->emit_event("topic_vx",2,file_hash,file_name.c_str());
        ctx->arg("tx_id", tx_id);
        ctx->log("call save() tx_id:" + tx_id);
        ctx->log("call save() file_hash:" + file_hash);
        ctx->log("call save() file_name:" + file_name);
        std::string test_str = tx_id + " " + file_name + " " + file_hash;
        ctx->put_object(file_hash, test_str);
        ctx->log("put success:" + test_str);
        ctx->success(test_str);
    }

    void find_by_file_hash()
    {
        Context *ctx = context();
        std::string file_hash;
        ctx->arg("file_hash", file_hash);
        std::string value;
        EasyCodecItems *value_items;
        ctx->get_object(file_hash, &value);
        ctx->log(value);
        value_items = easy_unmarshal((byte *)value.data());
        std::string value_str = value_items->get_value("value");
        ctx->log("result: " + value_str);
        ctx->success(value_str);
        delete (value_items);
    }

    void functional_verify()
    {
        Context *ctx = context();
        std::string value;
        std::string value_str;
        EasyCodecItems *value_items;
        ctx->log("===================================functionTest start===================================");
        ctx->get_object("test", &value);
        value_items = easy_unmarshal((byte *)value.data());
        value_str = value_items->get_value("value");
        ctx->log("result: " + value_str);

        ctx->put_object("test", "北京欢迎你");

        ctx->get_object("test", &value);
        value_items = easy_unmarshal((byte *)value.data());
        value_str = value_items->get_value("value");
        ctx->log("result: " + value_str);

        ctx->delete_object("test");
        ctx->get_object("test", &value);
        value_items = easy_unmarshal((byte *)value.data());
        value_str = value_items->get_value("value");
        ctx->log("result: " + value_str);
        delete (value_items);
        {
            EasyCodecItems *parameters = new EasyCodecItems(1);
            std::string resp;
            std::string param_value = "test";
            EasyCodecItems *call_items;
            parameters->ecitems[0].key = (char *)"file_hash";
            parameters->ecitems[0].key_type = easy_key_type_user;
            parameters->ecitems[0].value_type = easy_value_type_string;
            parameters->ecitems[0].value = (char *)param_value.data();
            ctx->call("contract01", "save", parameters, &resp);
            call_items = easy_unmarshal((byte *)resp.data());
            std::string result;
            result = call_items->get_value("result");
            ctx->log("[call save] result: [" + result + "]");
        }
        {
            EasyCodecItems *parameters = new EasyCodecItems(1);
            std::string resp;
            std::string param_value = "test";
            EasyCodecItems *call_items;
            parameters->ecitems[0].key = (char *)"file_hash";
            parameters->ecitems[0].key_type = easy_key_type_user;
            parameters->ecitems[0].value_type = easy_value_type_string;
            parameters->ecitems[0].value = (char *)param_value.data();
            ctx->call("contract01", "find_by_file_hash", parameters, &resp);
            call_items = easy_unmarshal((byte *)resp.data());
            std::string result;
            int32_t code = -1;
            code = atoi(call_items->get_value("code").c_str());
            if (code == SUCCESS)
            {
                result = call_items->get_value("result");
                ctx->log("[call find_by_file_hash] result: [" + result + "]");
            }
            else
            {
                ctx->log("failed call find_by_file_hash");
            }
            delete (parameters);
            delete (call_items);
        }
    }
};

// 在创建本合约时, 调用一次init方法. ChainMaker不允许用户直接调用该方法.
WASM_EXPORT void init_contract()
{
    Counter counter;
    counter.init_contract();
}

// 在升级本合约时, 对于每一个升级的版本调用一次upgrade方法. ChainMaker不允许用户直接调用该方法.
WASM_EXPORT void upgrade()
{
    Counter counter;
    counter.init_contract();
}

WASM_EXPORT void functional_verify()
{
    Counter counter;
    counter.functional_verify();
}
WASM_EXPORT void save()
{
    Counter counter;
    counter.save();
}

WASM_EXPORT void find_by_file_hash()
{
    Counter counter;
    counter.find_by_file_hash();
}

WASM_EXPORT void increase()
{
    Counter counter;
    counter.increase();
}

WASM_EXPORT void query()
{
    Counter counter;
    counter.query();
}

WASM_EXPORT void set_store()
{
    Counter counter;
    counter.set_store();
}

WASM_EXPORT void get_store()
{
    Counter counter;
    counter.get_store();
}

WASM_EXPORT void upgrade_set_store()
{
    Counter counter;
    counter.upgrade_set_store();
}

WASM_EXPORT void upgrade_get_store()
{
    Counter counter;
    counter.upgrade_get_store();
}


WASM_EXPORT void set_store_no_log()
{
    Counter counter;
    counter.set_store_no_log();
}

WASM_EXPORT void get_store_no_log()
{
    Counter counter;
    counter.get_store_no_log();
}

