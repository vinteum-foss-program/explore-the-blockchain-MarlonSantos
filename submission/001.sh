#!/bin/bash

# What is the hash of block 654,321?

getBlockHash() {
  local blockNumber=$1
  local blockHash
  blockHash=$(bitcoin-cli getblockhash "$blockNumber" 2>/dev/null)
  if [ $? -eq 0 ]; then
    echo "    O hash do bloco $blockNumber é: $blockHash"
  else
    echo "    Erro: Não foi possível obter o hash do bloco $blockNumber."
  fi
}

echo "Questão 01:"
echo ""
echo "  What is the hash of block 654,321?"
echo ""
echo "  Resposta:"
echo ""
blockNumber=654321
getBlockHash "$blockNumber"


