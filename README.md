To test foundry via local :
forge script script/Privacy.s.sol -vvvv

And to broadcoast and deploy it on amoy :

forge script script/Privacy.s.sol --rpc-url $AMOY_RPC_URL --private-key $PRIVATE_KEY --broadcast

Pour l'explication du code, on fait un brute force pour trouver la clé
