object ModelEntidadePedido: TModelEntidadePedido
  OldCreateOrder = False
  Height = 111
  Width = 299
  object qryPedidos: TFDQuery
    Connection = ModelConexao.conConexaoServidor
    SQL.Strings = (
      'SELECT numero, data_emissao, codigo_cliente, valor_total'
      'FROM pedidos'
      '&clausula_where'
      'ORDER BY numero')
    Left = 40
    Top = 8
    MacroData = <
      item
        Value = Null
        Name = 'CLAUSULA_WHERE'
      end>
    object qryPedidosnumero: TFDAutoIncField
      FieldName = 'numero'
      Origin = 'numero'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryPedidosdata_emissao: TDateField
      FieldName = 'data_emissao'
      Origin = 'data_emissao'
      Required = True
    end
    object qryPedidoscodigo_cliente: TWideStringField
      FieldName = 'codigo_cliente'
      Origin = 'codigo_cliente'
      Required = True
      Size = 8
    end
    object qryPedidosvalor_total: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'valor_total'
      Origin = 'valor_total'
    end
  end
  object qryPedidos_Produtos: TFDQuery
    OnCalcFields = qryPedidos_ProdutosCalcFields
    OnNewRecord = qryPedidos_ProdutosNewRecord
    MasterSource = dsPedidos
    MasterFields = 'numero'
    DetailFields = 'numero_pedido'
    Connection = ModelConexao.conConexaoServidor
    SQL.Strings = (
      
        'SELECT id, numero_pedido, codigo_produto, quantidade, valor_unit' +
        'ario'
      'FROM pedidos_produtos'
      'WHERE numero_pedido = :numero'
      'ORDER BY id')
    Left = 156
    Top = 8
    ParamData = <
      item
        Name = 'NUMERO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
    object qryPedidos_Produtosid: TFDAutoIncField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qryPedidos_Produtosnumero_pedido: TLongWordField
      FieldName = 'numero_pedido'
      Origin = 'numero_pedido'
      Required = True
    end
    object qryPedidos_Produtoscodigo_produto: TWideStringField
      FieldName = 'codigo_produto'
      Origin = 'codigo_produto'
      Required = True
      Size = 8
    end
    object qryPedidos_Produtosdescricao_produto_lookup: TStringField
      FieldKind = fkLookup
      FieldName = 'descricao_produto_lookup'
      LookupDataSet = ModelEntidadeProduto.qryProdutos
      LookupKeyFields = 'codigo'
      LookupResultField = 'descricao'
      KeyFields = 'codigo_produto'
      Size = 255
      Lookup = True
    end
    object qryPedidos_Produtosquantidade: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'quantidade'
      Origin = 'quantidade'
    end
    object qryPedidos_Produtosvalor_unitario: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'valor_unitario'
      Origin = 'valor_unitario'
    end
    object qryPedidos_Produtosvalor_total: TFloatField
      FieldKind = fkCalculated
      FieldName = 'valor_total'
      Calculated = True
    end
  end
  object dsPedidos: TDataSource
    AutoEdit = False
    DataSet = qryPedidos
    Left = 40
    Top = 52
  end
end
