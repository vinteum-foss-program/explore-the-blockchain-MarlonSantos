#!/bin/bash

# How many new outputs were created by block 123,456?

countNewOutputs() {
  local blockHeight=$1
  local blockHash=$(bitcoin-cli getblockhash "$blockHeight" 2>/dev/null)

  if [ $? -ne 0 ]; then
    echo "    Erro: Não foi possível obter o hash do bloco $blockHeight."
    return
  fi

  local blockDetails=$(bitcoin-cli getblock "$blockHash" 2>/dev/null)

  if [ $? -ne 0 ]; then
    echo "    Erro: Não foi possível obter os detalhes do bloco $blockHeight."
    return
  fi
  # Contando outputs
  local totalOutputs=0
  local txids=$(echo "$blockDetails" | awk '/"tx": \[/,/\]/' | grep -v '"tx":' | tr -d '",[]' | sed '/^\s*$/d')
  for txid in $txids; do
    # # Id da transação:
    # echo "Transação: $txid" >&2
    totalOutputs=$((totalOutputs + 1))
    # # Detalhes da transação:
    # rawTx=$(bitcoin-cli getrawtransaction "$txid" true 2>/dev/null)
    # if [ $? -eq 0 ] && [ -n "$rawTx" ]; then
    #   echo "$rawTx" | grep -oP '"value":\s*[0-9.]+' | sed 's/"value":/  Output:/' | awk '{print $2 " BTC"}'
    # else
    #   echo "  Erro ao obter detalhes da transação $txid." >&2
    # fi
  done
#   echo "    O número total de outputs no bloco $blockHeight é: $totalOutputs."
  echo "$totalOutputs"
}

# echo "Questão 03:"
# echo ""
# echo "  How many new outputs were created by block 123,456?"
# echo ""
# echo "Obs.: Dependendo do tamanho do bloco, o precessamento pode demorar bastante."
# echo "Por favor, aguarde..."
# echo ""
# echo "  Resposta:"
# echo ""
blockHeight=123456
countNewOutputs "$blockHeight"