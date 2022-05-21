// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

//發行總量
uint256 constant MAX_MINT_COUNT = 1000;

contract KnotNFT is ERC721, ERC721Enumerable, Ownable, ERC721Burnable{

    //---------------
    //initialize
    //---------------

    //當前已經mint的數量
    uint256 currentMintCount = 0;
    
    //鑄造指定NFT
    constructor() ERC721("Knot NFT", "KNFT") {}

    //將NFT默認圖面放置IPFS
    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/QmYJEQySJFrrXG7HhucmwzcgHiFv7pyZmM8jnZw8viFDZX";
    }

    //------------
    //override
    //------------

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

    //
    /**
    * @dev 鑄造, 只有合約擁有者可以使用此方法。
    * @param to 指定地址
    * @param tokenId NFT ID
    */
    function safeMint(address to, uint256 tokenId) private onlyOwner {
        _safeMint(to, tokenId);
    }

    /**
    * @dev 發行NFT, 設置總量, 只有合約擁有者可以使用此方法。
    * @param amount 發行量
    */
    function publishKnotNFT(uint256 amount) public onlyOwner {
        publishKnotNFT(amount, msg.sender);
    }

    /**
    * @dev 發行NFT, 設置總量, 只有合約擁有者可以使用此方法。
    * @param amount 指定接收者
    * @param amount 發行量
    */
    function publishKnotNFT(uint256 amount, address receiver) public onlyOwner {
        require(amount > 0, unicode"KnotNFT: 鑄造需大於0");
        require(receiver != address(0), "KnotNFT: mint to the zero address");

        //檢查是否可以鑄造
        require(isMintable(amount), unicode"KnotNFT: 發行總量超過上限");

        for(uint256 i = 0; i < amount; i++) {
            uint256 tokenID = currentMintCount++;
            safeMint(receiver, tokenID);
        }
    }

    //
    /**
    * @dev 查詢剩餘可鑄造數量
    */
    function mintableCount() public view returns (uint256 count){
        return MAX_MINT_COUNT - currentMintCount;
    }

    //
    /**
    * @dev 剩餘可鑄造數量是否可以再接受新的鑄造數量
    * @return result 是否可鑄造
    */
    function isMintable(uint256 amount) view private returns (bool result){
       return mintableCount() > amount;
    }

    //
    /**
    * @dev 傳送多個NFT給指定帳號
    * @param tokenIDs NFT token ID
    * @param receiver 接受者地址
    */
    function transferNFTsTo(uint256[] memory tokenIDs, address receiver) public onlyOwner{
        require(tokenIDs.length > 0, "KnotNFT: Token ID is zero.");
        require(receiver != address(0), "KnotNFT: mint to the zero address");

        for (uint256 i = 0; i < tokenIDs.length; i++) {
            safeTransferFrom(msg.sender, receiver, tokenIDs[i]);
        }
    }
}