// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";

contract FlightTicketNFT is ERC721 {
    uint256 public currentTokenId = 1;

    constructor() ERC721("FlightTicketNFT", "FLIGHT_TICKET_NFT") {}

    function mint(address to) public {
        _mint(to, currentTokenId);
        currentTokenId++;
    }
}
