# Flight Booking Prover and Verifier /w vLayer's Email Proof

## Overview 

- This is the **Flight Booking Prover and Verifier**, which enable a passanger to get a seamless experience to receive a filght ticket (NFT) while the passanger's booking is secury validated thanks to the `ZK proof of flight booking` by using a **flight booking confirmation email** and `Email Proof` of `vLayer`.


## Userflow

- 1/ When a passenger would book a flight ticket through either an airline's official website or an online travel agency (OTA), the passanger will receive a booking confirmation email from them once the passanger booked a filght.

- 2/ Once a passenger would receive an booking confirmation email, the passanger would call the `generateProofOfFlightBookingFromFlightBookingConfirmationEmail()` function in the `FlightBookingEmailProver.sol` in order to generate a ZK Proof of a flight booking from the booking confirmation email.

- 3/ The passanger would call the `claimFlightTicket()` function in the `FlightBookingEmailVerifier.sol`. If a given `Proof`
 is a valid proof (and it is validated the passanger has not claimed a filght ticket yet), a flight ticket NFT will be minted to the passanger.