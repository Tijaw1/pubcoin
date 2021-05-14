# Pubcoin
## *"Bringing crypto to your local breweries"*

![beer](Images/beersm.png)

## Team Members:
___ 
Matthew Newkirk  
James Reeves  
Blake Cizek  
Abdullahi Said  
Endalkachew Desta  
Matt Houk  
<br><br>
## Motivation & Learning Objectives:
___
- Develop technical expertise in creating fungible tokens and transaction functions deployed as solidity contracts on the ethereum blockchain
<br><br>
## Project Objectives:
___
- Leveraging ERC20, create a TaaS (Token-as-a-Service) marketplace for small businesses, breweries for this iteration, to reward its customers for brand loyalty and for customers to exchange their tokens across the network
<br><br>
## Project Summary:
___
- Developed and minted the “PubCoin” as the asset by which businesses can register a stake in the loyalty token and/or mint their own token (if required) at a specified exchange rate for PubCoins
- Customers who register on the “PubCoin” marketplace can exchange tokens with fellow patrons and be rewarded additional tokens or exchange their balance for product/services by their brewery of choice for brand loyalty 

## Conceptual Diagram
___
### *Multi-Token System*
![pubcoindiag_multi](Images/pubcoinOGsm.png)
<br><br>
### *Single-Token System*
![pubcoindiag_single](Images/pubcoinsimplesm.png)

<br><br>
## Technical Summary
___
### *Tools & Standards used:*
- Developed in Remix and used MetaMask to deploy locally via Ganache and to the [Ropsten Testnet](https://ropsten.etherscan.io/tx/0x6e5631a3b38d31ba1351308443c26b3db2788ddbdb9a98028b8597380484e8ab)
- PubCoin token was minted using standards from ERC20, ERC20 Mintable and ERC20 Detailed
### *Contracts developed:*
- **Pubcoin** contract used to mint **“PubCoin”**, and any unique brewery token
- **PointsTokenStorage** holds all the necessary state variables to carry out the storage of any contract.
- **Ownable** holds the owner address providing basic authorization control. 
- **PointsTokenStorage** and **Ownable** contracts are used to initialize **PubCoin_Points**
- **PubCoin_Points** contracts designed to enable registration of businesses and customers and the transaction of **PubCoins** across the marketplace. It holds the storage of the token contract and delegates every call to the current implementation set. It can also be modified to allow upgrade the token's behaviour towards further implementations, and provides basic authorization control functionalities. The set up is built with the concept of anonymity in mind. If and when anonymity becomes a lesser of a concern for the users, provisions have been made to accomadte what is to come.
### *Why Blockchain for Rewards/Loyalty Points system?*
Traditional loyalty systems suffer from low redemption rates, high costs, few customer incentives and security concerns
Blockchain systems offer open systems, less clutter, more flexibility, reduced costs, overall transparency, less fraud, and more security
Value Adds: Easier implementation, better accounting, happier customers, access to a network of loyal customers
<br><br>
## PubCoin Demo
___
### *Initial Deployment*
![](Images/initial_deployment.gif)
### *Initialization Registration*
![](Images/initialization_registration.gif)
### *One Click dApp Deployment*
![](Images/oneclickdapp_transfer.gif)
<br><br>
## Retrospective
___
### *Challenges*:
- Working backwards from the original ideas of providing every small business with a means to create a token to reward customers and to create excitement around their brand took many discussions to convert concept scope to code
- Still haven’t quite fully rationalized both in concept and in execution the dynamics of creating a Multi-token vs Single-Global-token for “PubCoin” loyalty points
- A “teething” experience in developing expertise in solidity and deploying to a Testnet 
- Issues in creating a front-end to the contracts, using One Click dApp as the constructor
### *Future Roadmap:*
- Iron out tokennomics of a multi-token vs. single-token loyalty marketplace
Evaluate If ERC777 is a better choice than ERC20
Harden development of a front-end web application for the contracts

