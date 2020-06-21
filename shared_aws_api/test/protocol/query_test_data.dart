final testSuites = [
  {
    'description': 'Scalar members',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'Foo': {'shape': 'StringType'},
          'Bar': {'shape': 'StringType'},
          'Baz': {'shape': 'BooleanType'}
        }
      },
      'StringType': {'type': 'string'},
      'BooleanType': {'type': 'boolean'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {'Foo': 'val1', 'Bar': 'val2'},
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&Foo=val1&Bar=val2'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {'Baz': true},
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&Baz=true'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {'Baz': false},
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&Baz=false'
        }
      }
    ]
  },
  {
    'description': 'Nested structure members',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'StructArg': {'shape': 'StructType'}
        }
      },
      'StructType': {
        'type': 'structure',
        'members': {
          'ScalarArg': {'shape': 'StringType'}
        }
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'StructArg': {'ScalarArg': 'foo'}
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&StructArg.ScalarArg=foo'
        }
      }
    ]
  },
  {
    'description': 'List types',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'ListArg': {'shape': 'ListType'}
        }
      },
      'ListType': {
        'type': 'list',
        'member': {'shape': 'Strings'}
      },
      'Strings': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'ListArg': ['foo', 'bar', 'baz']
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&ListArg.member.1=foo&ListArg.member.2=bar&ListArg.member.3=baz'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {'ListArg': []},
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&ListArg='
        }
      }
    ]
  },
  {
    'description': 'Flattened list',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'ScalarArg': {'shape': 'StringType'},
          'ListArg': {'shape': 'ListType'},
          'NamedListArg': {'shape': 'NamedListType'}
        }
      },
      'ListType': {
        'type': 'list',
        'member': {'shape': 'StringType'},
        'flattened': true
      },
      'NamedListType': {
        'type': 'list',
        'member': {'shape': 'StringType', 'locationName': 'Foo'},
        'flattened': true
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'ScalarArg': 'foo',
          'ListArg': ['a', 'b', 'c']
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&ScalarArg=foo&ListArg.1=a&ListArg.2=b&ListArg.3=c'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'NamedListArg': ['a']
        },
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&Foo.1=a'
        }
      }
    ]
  },
  {
    'description': 'Serialize flattened map type',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'MapArg': {'shape': 'StringMap'}
        }
      },
      'StringMap': {
        'type': 'map',
        'key': {'shape': 'StringType'},
        'value': {'shape': 'StringType'},
        'flattened': true
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'MapArg': {'key1': 'val1', 'key2': 'val2'}
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&MapArg.1.key=key1&MapArg.1.value=val1&MapArg.2.key=key2&MapArg.2.value=val2'
        }
      }
    ]
  },
  {
    'description': 'Non flattened list with LocationName',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'ListArg': {'shape': 'ListType'}
        }
      },
      'ListType': {
        'type': 'list',
        'member': {'shape': 'StringType', 'locationName': 'item'}
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'ListArg': ['a', 'b', 'c']
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&ListArg.item.1=a&ListArg.item.2=b&ListArg.item.3=c'
        }
      }
    ]
  },
  {
    'description': 'Flattened list with LocationName',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'ScalarArg': {'shape': 'StringType'},
          'ListArg': {'shape': 'ListType'}
        }
      },
      'ListType': {
        'type': 'list',
        'member': {'shape': 'StringType', 'locationName': 'ListArgLocation'},
        'flattened': true
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'ScalarArg': 'foo',
          'ListArg': ['a', 'b', 'c']
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&ScalarArg=foo&ListArgLocation.1=a&ListArgLocation.2=b&ListArgLocation.3=c'
        }
      }
    ]
  },
  {
    'description': 'Serialize map type',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'MapArg': {'shape': 'StringMap'}
        }
      },
      'StringMap': {
        'type': 'map',
        'key': {'shape': 'StringType'},
        'value': {'shape': 'StringType'}
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'MapArg': {'key1': 'val1', 'key2': 'val2'}
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&MapArg.entry.1.key=key1&MapArg.entry.1.value=val1&MapArg.entry.2.key=key2&MapArg.entry.2.value=val2'
        }
      }
    ]
  },
  {
    'description': 'Serialize map type with locationName',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'MapArg': {'shape': 'StringMap'}
        }
      },
      'StringMap': {
        'type': 'map',
        'key': {'shape': 'StringType', 'locationName': 'TheKey'},
        'value': {'shape': 'StringType', 'locationName': 'TheValue'}
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'MapArg': {'key1': 'val1', 'key2': 'val2'}
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&MapArg.entry.1.TheKey=key1&MapArg.entry.1.TheValue=val1&MapArg.entry.2.TheKey=key2&MapArg.entry.2.TheValue=val2'
        }
      }
    ]
  },
  {
    'description': 'Base64 encoded Blobs',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'BlobArg': {'shape': 'BlobType'}
        }
      },
      'BlobType': {'type': 'blob'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {'BlobArg': 'foo'},
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&BlobArg=Zm9v'
        }
      }
    ]
  },
  {
    'description': 'Base64 encoded Blobs nested',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'BlobArgs': {'shape': 'BlobsType'}
        }
      },
      'BlobsType': {
        'type': 'list',
        'member': {'shape': 'BlobType'},
        'flattened': true
      },
      'BlobType': {'type': 'blob'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'BlobArgs': ['foo']
        },
        'serialized': {
          'uri': '/',
          'body': 'Action=OperationName&Version=2014-01-01&BlobArgs.1=Zm9v'
        }
      }
    ]
  },
  {
    'description': 'Timestamp values',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'TimeArg': {'shape': 'TimestampType'},
          'TimeCustom': {
            'timestampFormat': 'unixTimestamp',
            'shape': 'TimestampType'
          },
          'TimeFormat': {'shape': 'TimestampFormatType'}
        }
      },
      'TimestampFormatType': {
        'timestampFormat': 'unixTimestamp',
        'type': 'timestamp'
      },
      'TimestampType': {'type': 'timestamp'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'TimeArg': DateTime.fromMillisecondsSinceEpoch(1422172800 * 1000),
          'TimeCustom': DateTime.fromMillisecondsSinceEpoch(1422172800 * 1000),
          'TimeFormat': DateTime.fromMillisecondsSinceEpoch(1422172800 * 1000)
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&TimeArg=2015-01-25T08%3A00%3A00Z&TimeCustom=1422172800&TimeFormat=1422172800'
        }
      }
    ]
  },
  {
    'description': 'Recursive shapes',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'RecursiveStruct': {'shape': 'RecursiveStructType'}
        }
      },
      'RecursiveStructType': {
        'type': 'structure',
        'members': {
          'NoRecurse': {'shape': 'StringType'},
          'RecursiveStruct': {'shape': 'RecursiveStructType'},
          'RecursiveList': {'shape': 'RecursiveListType'},
          'RecursiveMap': {'shape': 'RecursiveMapType'}
        }
      },
      'RecursiveListType': {
        'type': 'list',
        'member': {'shape': 'RecursiveStructType'}
      },
      'RecursiveMapType': {
        'type': 'map',
        'key': {'shape': 'StringType'},
        'value': {'shape': 'RecursiveStructType'}
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'RecursiveStruct': {'NoRecurse': 'foo'}
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&RecursiveStruct.NoRecurse=foo'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'RecursiveStruct': {
            'RecursiveStruct': {'NoRecurse': 'foo'}
          }
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&RecursiveStruct.RecursiveStruct.NoRecurse=foo'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'RecursiveStruct': {
            'RecursiveStruct': {
              'RecursiveStruct': {
                'RecursiveStruct': {'NoRecurse': 'foo'}
              }
            }
          }
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&RecursiveStruct.RecursiveStruct.RecursiveStruct.RecursiveStruct.NoRecurse=foo'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'RecursiveStruct': {
            'RecursiveList': [
              {'NoRecurse': 'foo'},
              {'NoRecurse': 'bar'}
            ]
          }
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&RecursiveStruct.RecursiveList.member.1.NoRecurse=foo&RecursiveStruct.RecursiveList.member.2.NoRecurse=bar'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'RecursiveStruct': {
            'RecursiveList': [
              {'NoRecurse': 'foo'},
              {
                'RecursiveStruct': {'NoRecurse': 'bar'}
              }
            ]
          }
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&RecursiveStruct.RecursiveList.member.1.NoRecurse=foo&RecursiveStruct.RecursiveList.member.2.RecursiveStruct.NoRecurse=bar'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'name': 'OperationName'
        },
        'params': {
          'RecursiveStruct': {
            'RecursiveMap': {
              'foo': {'NoRecurse': 'foo'},
              'bar': {'NoRecurse': 'bar'}
            }
          }
        },
        'serialized': {
          'uri': '/',
          'body':
              'Action=OperationName&Version=2014-01-01&RecursiveStruct.RecursiveMap.entry.1.key=foo&RecursiveStruct.RecursiveMap.entry.1.value.NoRecurse=foo&RecursiveStruct.RecursiveMap.entry.2.key=bar&RecursiveStruct.RecursiveMap.entry.2.value.NoRecurse=bar'
        }
      }
    ]
  },
  {
    'description': 'Idempotency token auto fill',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'Token': {'shape': 'StringType', 'idempotencyToken': true}
        }
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'http': {'method': 'POST'},
          'name': 'OperationName'
        },
        'params': {'Token': 'abc123'},
        'serialized': {
          'uri': '/',
          'headers': <String, dynamic>{},
          'body': 'Action=OperationName&Version=2014-01-01&Token=abc123'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'http': {'method': 'POST'},
          'name': 'OperationName'
        },
        'params': <String, dynamic>{},
        'serialized': {
          'uri': '/',
          'headers': <String, dynamic>{},
          'body':
              'Action=OperationName&Version=2014-01-01&Token=00000000-0000-4000-8000-000000000000'
        }
      }
    ]
  },
  {
    'description': 'Enum',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'shapes': {
      'InputShape': {
        'type': 'structure',
        'members': {
          'FooEnum': {'shape': 'EnumType'},
          'ListEnums': {'shape': 'EnumList'}
        }
      },
      'EnumType': {
        'type': 'string',
        'enum': ['foo', 'bar']
      },
      'EnumList': {
        'type': 'list',
        'member': {'shape': 'EnumType'}
      }
    },
    'cases': [
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'http': {'method': 'POST'},
          'name': 'OperationName'
        },
        'params': {
          'FooEnum': 'foo',
          'ListEnums': ['foo', '', 'bar']
        },
        'serialized': {
          'uri': '/',
          'headers': <String, dynamic>{},
          'body':
              'Action=OperationName&Version=2014-01-01&FooEnum=foo&ListEnums.member.1=foo&ListEnums.member.2=&ListEnums.member.3=bar'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'http': {'method': 'POST'},
          'name': 'OperationName'
        },
        'params': {'FooEnum': 'foo'},
        'serialized': {
          'uri': '/',
          'headers': <String, dynamic>{},
          'body': 'Action=OperationName&Version=2014-01-01&FooEnum=foo'
        }
      },
      {
        'given': {
          'input': {'shape': 'InputShape'},
          'http': {'method': 'POST'},
          'name': 'OperationName'
        },
        'params': <String, dynamic>{},
        'serialized': {
          'uri': '/',
          'headers': <String, dynamic>{},
          'body': 'Action=OperationName&Version=2014-01-01'
        }
      }
    ]
  },
  {
    'description': 'Endpoint host trait',
    'metadata': {'protocol': 'query', 'apiVersion': '2014-01-01'},
    'clientEndpoint': 'https://service.region.amazonaws.com',
    'shapes': {
      'StaticInputShape': {
        'type': 'structure',
        'members': {
          'Name': {'shape': 'StringType'}
        }
      },
      'MemberRefInputShape': {
        'type': 'structure',
        'members': {
          'Name': {'shape': 'StringType', 'hostLabel': true}
        }
      },
      'StringType': {'type': 'string'}
    },
    'cases': [
      {
        'given': {
          'name': 'StaticOp',
          'input': {'shape': 'StaticInputShape'},
          'http': {'method': 'POST'},
          'endpoint': {'hostPrefix': 'data-'}
        },
        'params': {'Name': 'myname'},
        'serialized': {
          'uri': '/',
          'body': 'Action=StaticOp&Version=2014-01-01&Name=myname',
          'host': 'data-service.region.amazonaws.com'
        }
      },
      {
        'given': {
          'name': 'MemberRefOp',
          'input': {'shape': 'MemberRefInputShape'},
          'http': {'method': 'POST'},
          'endpoint': {'hostPrefix': 'foo-{Name}.'}
        },
        'params': {'Name': 'myname'},
        'serialized': {
          'uri': '/',
          'body': 'Action=MemberRefOp&Version=2014-01-01&Name=myname',
          'host': 'foo-myname.service.region.amazonaws.com'
        }
      }
    ]
  }
];
