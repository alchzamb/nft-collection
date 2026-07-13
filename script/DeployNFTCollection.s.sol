// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol"; //Librería para correr scripts
import {BANFTCollection} from "../src/BANFTCollection.sol"; //El contrato a correr

contract DeplyNFTCollection is Script {
    //Para los scripts usamos siempre la función "run"
    //Deploy: para deployear necesitamos saber el comando para deployear y en que red vamos a deployear
    function run() external returns (BANFTCollection) {
        //Para deployar un smart contract con una cartera necesitamos su clave privada, tendríamos que autorizar que esa
        //cartera, con esa clave privada deployee el smart contract. Lo haremos con estos comandos de FOUNDRY:
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY"); //cogemos la PRIVATE_KEY del archivo .env
        vm.startBroadcast(deployerPrivateKey);

        //estos eran los parámetros de nuestro constructor en el contrato src/BANFTCollection
        string memory name_ = "Blockchain Acelerator NFT";
        string memory symbol_ = "BANFT";
        uint256 totalSupply_ = 2;
        //enlace completo de la carpeta uri subida en pinata: ipfs://link/
        string memory baseUri_ = "ipfs://bafybeigqfube27qe74lzdjrwr3t32brxprzppr5ts5q7gpv6ngbf6ux5tm/";
        //Creamos y definimos el objeto BANFTCollection con sus parámetros
        BANFTCollection nftCollection = new BANFTCollection(name_, symbol_, totalSupply_, baseUri_);

        vm.stopBroadcast();
        return nftCollection;
    }
}
