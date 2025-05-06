import {Strings} from "@openzeppelin-contracts-5.0.1/utils/Strings.sol";
import {Proof} from "vlayer-0.1.0/Proof.sol";
import {Prover} from "vlayer-0.1.0/Prover.sol";
import {RegexLib} from "vlayer-0.1.0/Regex.sol";
import {VerifiedEmail, UnverifiedEmail, EmailProofLib} from "vlayer-0.1.0/EmailProof.sol";

/**
 * @title - The Flight Booking Email Prover contract 
 */
contract FlightBookingEmailProver is Prover {
    using RegexLib for string;
    using Strings for string;
    using EmailProofLib for UnverifiedEmail;

    /**
     * @notice - The function to generate a ZK Proof of a flight booking from a flight booking confirmation email
     */
    function generateProofOfFlightBookingFromFlightBookingConfirmationEmail(UnverifiedEmail calldata unverifiedEmail, address targetWallet)
        public
        view
        returns (Proof memory, bytes32, address, string memory)
    {
        VerifiedEmail memory email = unverifiedEmail.verify();

        // @dev - Extract a subject from an email header and validate whether or not it correspond to the correct subject. 
        // @dev - [NOTE]: This correct subject should be customized depends on which airline's official website or an online travel agency (OTA)'s website an passenger booked. 
        require(email.subject.equal("Booking Confirmation - Booking ID #xxxxx"), "incorrect subject");
        
        // @dev - Extract an airline's domain from email address - if a passenger book a flight via an airline's official website.
        // @dev - Or, Extract a flight booking provider's domain from email address - if a passenger book a flight via an online travel agency (OTA)'s website.
        string[] memory captures = email.from.capture("^[^@]+@([^@]+)$");
        require(captures.length == 2, "invalid email domain");
        require(bytes(captures[1]).length > 0, "invalid email domain");

        return (proof(), sha256(abi.encodePacked(email.from)), sha256(abi.encodePacked(email.subject)), targetWallet, captures[1]);
    }
}
