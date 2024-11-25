#!/bin/bash

# (true / false) Verify the signature by this address over this message:
#   address: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   message: `1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa`
#   signature: `HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM=`

verifyMessageSignature() {
  local address=$1
  local signature=$2
  local message=$3

  local result=$(bitcoin-cli verifymessage "$address" "$signature" "$message" 2>/dev/null)

  if [ $? -eq 0 ]; then
    if [ "$result" == "true" ]; then
      echo "    A assinatura é válida. [true]"
    else
      echo "    A assinatura é inválida. [false]"
    fi
  else
    echo "    Erro: Não foi possível verificar a assinatura."
  fi
}

address="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
message="1E9YwDtYf9R29ekNAfbV7MvB4LNv7v3fGa"
signature="HCsBcgB+Wcm8kOGMH8IpNeg0H4gjCrlqwDf/GlSXphZGBYxm0QkKEPhh9DTJRp2IDNUhVr0FhP9qCqo2W0recNM="

echo "Questão 02:"
echo ""
echo "  (true / false) Verify the signature by this address over this message:"
echo "    address:  $address"
echo "    message: $message"
echo "    signature: $signature"
echo ""
echo "  Resposta:"
echo ""
verifyMessageSignature "$address" "$signature" "$message"