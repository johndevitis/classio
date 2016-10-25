# classio
MATLAB class IO magic.

# Use
Use `classio` as a superclass for any MATLAB class definition to inherit file read/write capability. Objects can be serialized (write) and de-serialized (read + auto-populate class properties).

*Currently only JSON is supported.*

# Example
A simple read/write example can be found in `examples/`.

The function `read_write_example` creates an instance of the `read_write_example_class` and uses the classio methods `obj2json` and `json2obj` to serialize and de-serialize the example object.

*MATLAB classdef file:*
```
classdef read_write_example_class < classio
	properties
        firstName = 'john'
        lastName = 'dev'
        age = 'dont ask'
	end
```

*JSON Output:*
```
{
	"read_write_example_class": {
		"firstName": "john",
		"lastName": "dev",
		"age": "dont ask"
	}
}
```
