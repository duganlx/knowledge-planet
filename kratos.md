## 1 proto文件

### 1.1 service写法

```protobuf
//Xxx为实体(message)
service CRMService {
	// 新建Xxx
	rpc AddXxx(AddXxxRequest) returns (AddXxxReply) {
		option (google.api.http) = {
			post: "/v1/xxx"
			body: "*"
		};
	}

	// 获取Xxx
	rpc GetXxx(GetXxxRequest) returns (GetXxxReply) {
		option (google.api.http) = {
			get: "/v1/xxx"
		};
	}
	
	// 列表Xxx
	rpc ListXxx(ListXxxRequest) returns (ListXxxReply) {
		option (google.api.http) = {
			get: "/v1/xxx/list"
		}
	}
	
	// 更新Xxx
	rpc UpdXxx(UpdXxxRequest) returns (UpdXxxReply) {
		option (google.api.http) = {
			put: "/v1/xxx/{XxxId}"
			body: "*"
		};
	}
	
	// 删除Xxx
	rpc DelXxx(DelXxxRequest) returns (DelXxxReply) {
		option (google.api.http) = {
			delete: "/v1/xxx/{XxxId}"
		};
	}
}

// rpc方法的注解信息
// 
// {{.MethodDescriptorProto.Name}} is a call with the method(s) {{$first := true}}{{range .Bindings}}{{if $first}}{{$first = false}}{{else}}, {{end}}{{.HTTPMethod}}{{end}} within the "{{.Service.Name}}" service.
// It takes in "{{.RequestType.Name}}" and returns a "{{.ResponseType.Name}}".
//
// ## {{.RequestType.Name}}
// | Field ID    | Name      | Type                                                       | Description                  |
// | ----------- | --------- | ---------------------------------------------------------  | ---------------------------- | {{range .RequestType.Fields}}
// | {{.Number}} | {{.Name}} | {{if eq .Label.String "LABEL_REPEATED"}}[]{{end}}{{.Type}} | {{fieldcomments .Message .}} | {{end}}
//
// ## {{.ResponseType.Name}}
// | Field ID    | Name      | Type                                                       | Description                  |
// | ----------- | --------- | ---------------------------------------------------------- | ---------------------------- | {{range .ResponseType.Fields}}
// | {{.Number}} | {{.Name}} | {{if eq .Label.String "LABEL_REPEATED"}}[]{{end}}{{.Type}} | {{fieldcomments .Message .}} | {{end}}
```



### 1.2 message写法

```protobuf
// Xxx实体
message Xxx {
	string Id=1;
	string Name=3;
	//...
}

// 新建Xxx
message AddXxxRequest {
	string Name=1;
	//...
}
message AddXxxReply {
	int32 Code=1;
	string Message=3;
	string XxxId=5;
}

// 获取Xxx
message GetXxxRequest {
	string Id=1;
}
message GetXxxReply {
	int32 Code=1;
	string Message=3;
	Xxx Data=4;
}

// 列表Xxx(过滤分页)
message ListXxxRequest {
	//第PageNum页
	int64 PageNum=5;
	//一页的记录数量
	int64 PageSize=10;
	//Xxx字段
	string Name
	//...(除主键的其他字段)
}
message ListXxxReply {
	int32 Code = 1;
	string Message = 5;
	//数据
	repeated Xxx Data=10;
	//总记录数
	int64 Total = 20;
	//总页数
	int64 PageSum =25;
}

// 更新&删除
message UDXxxRequest {
	// 主键
	string XxxId=1;
	// 需要修改的字段
	string Name=2;
	// ...
}
message UDXxxReply {
	int32 Code = 1;
	string Message = 5;
}
```



### 1.3 字段验证编写

- `[(validate.rules).string.len=30]` 长度限制
- `[(validate.rules).string = {min_len: 1, max_len: 16}]` 长度范围约束



## 2 XxxRepo接口命名

```go
type XxxRepo interface {
    Insert(context.Context, *Xxx) error
    SelectOne(context.Context, filter *Xxx) (*Xxx, error)
    SelectList(context.Context, filter *Xxx, pageNum int64, pageSize int64) (*PageResult, error)
    Update(context.Context, fields *Xxx) error
    DeleteList(context.COntext, ids *[]string) error
    Count(context.Context, filter *Xxx) (int64, error)
}

// 分页结果
type PageResult struct {
    Total int64 `json:"total"`
    PageSum int64 `json:"pageSum"`
    List interface{} `json:"list"`
}
```



