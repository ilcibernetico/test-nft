// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/Strings.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";


contract IlCiberneticoGoerli is Ownable, ERC721("Il Cibernetico NFT", "CIBENFT") {
  using Strings for uint256;
  uint tokenId;
  mapping(address=>tokenMetaData[]) public ownershipRecord;
  struct tokenMetaData{
    uint tokenId;
    uint timeStamp;
    string tokenURI;
  }

  function mintToken(address recipient) onlyOwner public {
    _safeMint(recipient, tokenId);
    ownershipRecord[recipient].push(tokenMetaData(tokenId, block.timestamp, "https://ilcibernetico.it/nftdata/"));
    tokenId = tokenId + 1;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    _requireMinted(tokenId);

    string memory baseURI = _baseURI();
    return bytes(baseURI).length > 0 ? string(abi.encodePacked(baseURI, tokenId.toString())) : "";
  }

  function _baseURI() internal view virtual override returns (string memory) {
      return "https://ilcibernetico.it/nftdata/";
  }
}