// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";

contract YDIYOI_IDENTICON_HACKATHON is
    ERC721,
    ERC721Enumerable,
    ERC721URIStorage,
    Ownable
{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    mapping(uint256 => string) public idenconHash;
    mapping(uint256 => int256) public lat;
    mapping(uint256 => int256) public lng;

    constructor() ERC721("You Drink It, You Own It, ALEPH HACKATHON", "YDIYOI.IDENTICON.HACKATHON") {}

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }


    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }


    function setIdenticonValues(uint256 tokenId, string memory _idenconHash, int256 _lat, int256 _lng) public onlyOwner {
        require(_exists(tokenId), "Token ID does not exist");
        idenconHash[tokenId] = _idenconHash;
        lat[tokenId] = _lat;
        lng[tokenId] = _lng;
    }

    function getIdenticonValues(uint256 tokenId) public view returns (string memory, int256, int256) {
        require(_exists(tokenId), "Token ID does not exists");
        return (idenconHash[tokenId], lat[tokenId], lng[tokenId]);
    }
}