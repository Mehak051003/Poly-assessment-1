// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFT is ERC721A, Ownable {
    constructor() Ownable() ERC721A("MyNFT", "MNFT") {}

    uint256 private limit = 5;
    string[] private descriptions = [
        "image of a whimsical creature ",
        "image of a DJ monkey with robotic limbs",
        "image of a punk rock porcupine with vibrant",
        "image of a crime-fighting squirrel with jetpack-propelled acrobatics or a caped chameleon that can blend into any environment",
        "image of a mesmerizing scene "
    ];
    mapping(uint256 => string) private _tokenURIs;


    function _baseURI() internal pure override returns (string memory) {
        return "QmPzWLahr3pBJm2V8A8L2EnYUbxedipYAjpcffpZSSA47A";
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) revert("No Token Exists");

        string memory baseURI = _baseURI();
        string memory tokenIdStr = _toString(tokenId);
        string memory extension = ".png";
    return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, "/", tokenIdStr, extension)) : '';
    }

    function promptDescription(uint256 tokenId) public view returns(string memory) {
        return descriptions[tokenId];
    }

    function mint(address reciever, uint256 quantity) external onlyOwner {
        require(reciever != address(0), "Invalid Address");
        require( totalSupply() < limit, "Maximum NFT Minted");
        _safeMint(reciever, quantity); 
    }
}