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
            System.debug('item doacao: ' + itemDoacao);
            Decimal totalDoacao = itemDoacao.Quantidade__c;
            for (ItemEstoque__c itemEstoque : records)
            {
                System.debug('item estqoue avaliado: ' + itemEstoque);
                if (itemDoacao.Produto__c.equals(itemEstoque.Produto__c))
                {
                    System.debug('item de estoque deu match com item de doação');
                    System.debug('totaldoacao: ' + totalDoacao);
                    if (totalDoacao == 0)
                    {
                        break;
                    }
                    else
                    {
                        System.debug('qtd em estoque: ' + itemEstoque.Quantidade__c);
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
                        
                        system.debug('total doacao foi pra: ' + totalDoacao);
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

}
