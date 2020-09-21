public without sharing class ItensEstoques implements IItensEstoques
{
    public List<ItemEstoque__c> records;

    public ItensEstoques(List<ItemEstoque__c> records) 
    {
        this.records = records;
    }

    public static ItensEstoques newInstance(List<ItemEstoque__c> records)
    {
        return new ItensEstoques(records);
    }

    public static ItensEstoques newInstance()
    {
        return new ItensEstoques(new List<ItemEstoque__c>());
    }

    public void devolveQuantidade(List<ItemDoacao__c> itens)
    {
        for (ItemDoacao__c itemDoacao : itens)
        {
            Integer i = 0;
            ItemEstoque__c item;
            do
            {
                item = records.get(i);
                i++;
            } while (i < records.size() && !item.Produto__c.equals(itemDoacao.Produto__c));

            if (item.Produto__c.equals(itemDoacao.Produto__c))
            {
                item.Quantidade__c += itemDoacao.Quantidade__c;
            }
        }
    }

    public void handleDoacoes(List<ItemDoacao__c> itensDoacoes)
    {
        for (ItemDoacao__c itemDoacao : itensDoacoes)
        {
            Decimal totalDoacao = itemDoacao.Quantidade__c;
            for (ItemEstoque__c itemEstoque : records)
            {
                if (itemDoacao.Produto__c.equals(itemEstoque.Produto__c))
                {
                    if (totalDoacao == 0)
                    {
                        break;
                    }
                    else
                    {
                        if (totalDoacao <= itemEstoque.Quantidade__c)
                        {
                            itemEstoque.Quantidade__c -= totalDoacao;
                            totalDoacao = 0;
                            break;
                        }
                        else
                        {
                            totalDoacao -= itemEstoque.Quantidade__c;
                            itemEstoque.Quantidade__c = 0;                        
                        }  
                        
                    }
                }
                
            }

            if (totalDoacao > 0)
            {
                itemDoacao.Quantidade__c.addError('Quantidade solicitada (' + itemDoacao.Quantidade__c + ') indisponível em estoque.');
            }
        }

        update records;
    }

    public void handleQtdEstoque(ItemDoacao__c item, Decimal totalDoacao, ItemCestaBasica__c itemCestaBasica) 
    {
        for (ItemEstoque__c itemEstoque : records)
        {
            if (totalDoacao == 0)
            {
                break;
            }
            else
            {
                if (itemCestaBasica.Item__c.equals(itemEstoque.Produto__c))
                {
                    if (itemEstoque.Quantidade__c > 0)
                    {
                        if (totalDoacao <= itemEstoque.Quantidade__c)
                        {
                            item.Quantidade__c += totalDoacao;
                            itemEstoque.Quantidade__c -= totalDoacao;
                            totalDoacao -= totalDoacao;
                        }
                        else
                        {
                            item.Quantidade__c += itemEstoque.Quantidade__c;
                            totalDoacao -= itemEstoque.Quantidade__c;
                            itemEstoque.Quantidade__c = 0;                        
                        }                    
                    }
                }
            }
        }  
    }

    public ItemEstoque__c createByMovimentacaoEntrada(Movimentacao__c record)
    {
        if  (record == null)
        {
            return null;
        }

        return new ItemEstoque__c(
            Estoque__c = record.Estoque__c,
            Produto__c = record.Produto__c,
            Quantidade__c = record.Quantidade__c
        );
    }

}