object ModelEntidadeProduto: TModelEntidadeProduto
  OldCreateOrder = False
  Height = 150
  Width = 215
  object qryProdutos: TFDQuery
    Connection = ModelConexao.conConexaoServidor
    SQL.Strings = (
      'SELECT codigo, descricao, preco_venda'
      'FROM produtos'
      '&clausula_where'
      'ORDER BY descricao')
    Left = 32
    Top = 8
    MacroData = <
      item
        Value = Null
        Name = 'CLAUSULA_WHERE'
      end>
    object qryProdutoscodigo: TWideStringField
      FieldName = 'codigo'
      Origin = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 8
    end
    object qryProdutosdescricao: TWideStringField
      FieldName = 'descricao'
      Origin = 'descricao'
      Required = True
      Size = 255
    end
    object qryProdutospreco_venda: TFloatField
      AutoGenerateValue = arDefault
      FieldName = 'preco_venda'
      Origin = 'preco_venda'
    end
  end
end
