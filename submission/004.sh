#!/bin/bash

# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`

calcularEnderecoTaproot() {
  local xpub=$1
  local indice=$2

  local descritorBase="tr($xpub/$indice)"
  descritorCompleto=$(bitcoin-cli getdescriptorinfo "$descritorBase" 2>/dev/null | grep -oP '(?<="descriptor": ")[^"]+')

  if [ $? -ne 0 ] || [ -z "$descritorCompleto" ]; then
    echo "    Erro: Falha ao gerar o checksum para o descritor." >&2
    exit 1
  fi

  resultado=$(bitcoin-cli deriveaddresses "$descritorCompleto" 2>/dev/null)
  if [ $? -ne 0 ]; then
    mensagemErro=$(bitcoin-cli deriveaddresses "$descritorCompleto" 2>&1)
    echo "    Erro: Falha ao derivar o endereço Taproot." >&2
    echo "      Motivo: $mensagemErro" >&2
    exit 1
  fi

  if [ -z "$resultado" ]; then
    echo "    Erro: O comando deriveaddresses retornou um resultado vazio. Verifique seu descritor." >&2
    echo "      Descritor usado: $descritorCompleto" >&2
    exit 1
  fi

  endereco=$(echo "$resultado" | tr -d '\n ' | grep -oP '(?<=\[")[^"]+(?="\])')
  if [ -z "$endereco" ]; then
    echo "    Erro: Não foi possível analisar o endereço a partir do resultado." >&2
    echo "      Resultado bruto: $resultado" >&2
    exit 1
  fi
  echo "    Endereço Taproot derivado: $endereco"
}

echo "Questão 04:"
echo ""
echo "  Using descriptors, compute the taproot address at index 100 derived from this extended public key:"
echo "    xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
echo ""
echo "  Resposta:"
echo ""
xpub="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
indice=100
calcularEnderecoTaproot "$xpub" "$indice"