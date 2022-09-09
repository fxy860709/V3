#! /bin/bash
echo "替换test_env和docker环境中的send工具"
tool_name="send_proposal_request_tool"
source_path="/mnt/datadisk0/chainmaker-go/test/send_proposal_request_tool/"
test_env_path="/mnt/datadisk0/ptf/docker_ver/test_env/"
docker_data_path="/mnt/datadisk0/ptf/docker_ver/perdata/testdata/Performance/bin/chainmaker/linux/"
echo "编译send tools"
cd $source_path
go mod download
go build
echo "替换test_env中的send工具"
cd $test_env_path
if [ ! -f "$tool_name" ]; then
	rm -f $tool_name
fi
cp "${source_path}${tool_name}" .
echo "替换docker中的send工具"
cd $docker_data_path
if [ ! -f "$tool_name" ]; then
        rm -f $tool_name
fi
cp "${source_path}${tool_name}" .
