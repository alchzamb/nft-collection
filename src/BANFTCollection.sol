// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.24;
import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Strings} from "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

//Vamos a deployear este smart contract en una red real, la de Arbitrum, para ello además debemos crear un script de despliegue
contract BANFTCollection is
    ERC721 //Heredo las funciones de ERC721
{
    using Strings for uint256; //indico el casteo para el cual quiero usar mi librería

    uint256 public currentTokenId; //contador del Token, le permite al usuario elegir que Token mintear
    //currentTokenId: vale 0 por defecto
    uint256 public totalSupply; //Definimos la máxima cantidad de tokens a mintear
    string public baseUri; //El uri de la colección

    event MintNFT(address userAddress, uint256 tokenId);

    constructor(string memory name_, string memory symbol_, uint256 totalSupply_, string memory baseUri_)
        ERC721(name_, symbol_)
    {
        //Defino mi constructor y el del ERC721
        totalSupply = totalSupply_;
        baseUri = baseUri_;
    }

    //Externalizo la función _safeMint para que sea "external" y mis usuarios puedan mintear sus tokens
    //Al pasar por parámetro currentTokenId, le estamos dando la posibilidad al usuario de mintear el token que el quiera,
    //Normalmente no suele ser así, sino, que se mintea en orden. La primera vez que el usuario llama a la función, mintea el [0],
    //Si la vuelve a llamar mintea el [1], y así sucesivamente usando un contador
    //Ej: TotalSupply = 5 -> [0 - 4]
    function mint() external {
        //¿Cómo funciona? El usuario mintea el cero, luego suma 1 y termina la función
        //Otro usuario entra, mintea el 1, y luego se actualiza a 2. Así sucesivamente...

        //Metemos un require que nos chequee si es o no el último token
        require(currentTokenId < totalSupply, "Sold out");
        _safeMint(msg.sender, currentTokenId);
        //No se puede mintear un token 2 veces, cada token tiene su propia numeración, he ahí la importancia del token Id
        uint256 id = currentTokenId; //cacheo currentTokenId con la variable "id"
        currentTokenId++; //contador
        emit MintNFT(msg.sender, id);
        //Tenemos que manejar nuestro tokenId, para usarlo apropiadamente (es el corazón de los NFT)
    }

    //Función que nos devuleve el uri de nuestra colección
    //Sobreescribimos y modificamos la función para que nos devuelva nuestro baseUri
    function _baseURI() internal view virtual override returns (string memory) {
        return baseUri;
    }

    //Con esta función ahora si tenemos el uri completo de toda la colección de cada elemento de ella
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = _baseURI();
        //Para hacer el casteo usamos la librería "Strings"
        return bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString(), ".json") : "";
    }
}
