// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.21;

import { Proof } from "vlayer-0.1.0/Proof.sol";
import { Verifier } from "vlayer-0.1.0/Verifier.sol";

import { FlightBookingEmailProver } from "./FlightBookingEmailProver.sol";
import { FlightTicketNFT } from "./FlightTicketNFT.sol";

/**
 * @title - The Flight Booking Email Verifier contract 
 */
contract FlightBookingEmailVerifier is Verifier {
    address public prover;
    FlightTicketNFT public flightTicketNFT;

    mapping(address => bool) public claimed;

    constructor(address _prover, address _flightTicketNFT) {
        prover = _prover;
        flightTicketNFT = FlightTicketNFT(_flightTicketNFT);
    }

    /**
     * @dev - A passenger can claim if a given proof is a valid proof and has not claimed a flight ticket yet
     */
    function claimFlightTicket(Proof calldata, address claimer, uint256 balance)
        public
        onlyVerified(prover, FlightBookingEmailProver.generateProofOfFlightBookingFromFlightBookingConfirmationEmail.selector)
    {
        require(!claimed[claimer], "The flight ticket has already been claimed");

        claimed[claimer] = true;
        flightTicketNFT.mint(claimer);
    }
}
