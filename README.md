# A Blockchain-based Data Sharing Scheme using Attribute-Based Encryption and Semi-Fungible Tokens - Smart Contracts

This repository contains the smart contracts for a blockchain-based data-sharing scheme utilizing Ciphertext-Policy Attribute-Based Encryption (CP-ABE) and semi-fungible tokens.

## Project Structure

- **`contracts`**: Contains a Rust package wrapped as WebAssembly. The compiled WebAssembly files are located in the `public` directory.
- **`evaluation`**: Holds all the files necessary to build and run the web application, including the client-side logic and the key-generation server.
- **`scripts`**: Holds all the files necessary to build and run the web application, including the client-side logic and the key-generation server.

## Build Instructions

1. **Install dependencies**: Run `pnpm i` to install the required Node.js packages.
2. **Compile the smart contracts**: Run `pnpm compile` to compile the smart contracts in the repositry.
3. **Compile the smart contracts**: To deply a certain smart contract, run its corresponding deploy script, for example `pnpm hardhat run .\scripts\deploy\deployAttributeToken.ts`.

## Requirements

Before starting, ensure you have the following installed:

- **Node.js**: Required for npm packages and running Node.js commands.
- **pnpm**: A fast, efficient Node.js package manager.

## Envionrment Variables

You must have the following environment variables in a .env file:

- SEPOLIA_URL: An API url to connect to the sepolia blockchain, i.e., one provided by an Infura account
- PRIVATE_KEY: The private key of from a cryptorgraphic wallet, i.e., a metamask private key
