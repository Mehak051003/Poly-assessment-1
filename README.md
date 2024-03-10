# ERC20 Goerli to Mumbai Bridge Using fxPortal
This project demonstrates how to use the fxPortal contracts to transfer ERC20 tokens from Goerli to Mumbai.

## Description
In Proof of Stake, validators are chosen to validate transactions and create new blocks based on the number of tokens they hold and are willing to stake as collateral. The more tokens a validator stakes, the higher the probability they have of being chosen to create the next block.

### Steps for Bridging

1. Run npm i to install dependencies
2. Put your private key in the .env.examples file and rename to .env when finished
3. Run npx hardhat run scripts/deploy.js --network goerli to deploy ERC20 contract
4. Paste the newly deployed contract address in the tokenAddress variable for the other scripts
5. Make sure to fill in your public key
6. Run npx hardhat run scripts/mint.js --network goerli to mint tokens to your wallet
7. Run npx hardhat run scripts/approveDeposit.js --network goerli to approve and deposit your tokens to polygon
8. Wait 20-30ish minutes for tokens to show on polygon account
9. Use polyscan.com to check your account for the tokens. Once they arrive, you can click on the transaction to get the contract address for polygon.
10. Use this polygon contract address for your getBalance script's tokenAddress
11. Run npx hardhat run scripts/getBalance.js --network mumbai to see the new polygon balance

![image](https://github.com/Mehak051003/Poly-assessment-1/assets/118992603/92d89690-8edd-48c2-b257-9bb5cbc8c36d)

## Executing Program
```
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
```

## Authors

Mehak Thakur [mehakthakur051003@gmail.com]


## License

This project is licensed under the MIT License - see the LICENSE.md file for details

