/*CHANGE TO SHOULD BE BEFORE LAUNCH
	
    uint public _BLOCKS_PER_READJUSTMENT = 16; // should be 1024
    
NEED TO CHANGE mintToJustABAS to MintJustzkBTC function name, keeping the same for mining compadibility for now

Change Auctions to 12 days

Need to change startTime to 1 week after contract is launched blocktime.timestamp + 1 week

*/
// Zero Knowledge Bitcoin - zkBitcoin (zkBTC) Token - Token and Mining Contract
//
// Website: https://zkBitcoin.org
// Staking zkBitcoin / Ethereum LP dAPP: https://zkBitcoin.org/StakingETH/
// Staking zkBitcoin / 0xBitcoin LP dAPP: https://zkBitcoin.org/Staking0xBTC/
// Auctions dAPP: https://zkBitcoin.org/auctions/
// Github: https://github.com/zkBitcoin-Token/
// Discord: https://discord.gg/FwXGz5PvjF
//
// Distrubtion of Zero Knowledge Bitcoin Token - zkBitcoin (zkBTC) Token is as follows:
//
// 40% of zkBTC Token is distributed as Liquidiy Pools as rewards in the zkBitcoinStakingETH and zkBitcoinStaking0xBTC Contract which distributes tokens to users who deposit the Liquidity Pool.
// +
// 40% of zkBTC Token is distributed using zkBitcoin Contract(this Contract) which distributes tokens to users by using Proof of work. Computers solve a complicated problem to gain tokens!
// +
// 20% of zkBTC Token is Auctioned in the zkBitcoinAuctions Contract which distributes tokens to users who use Ethereum to buy tokens in fair price. Each auction lasts ~12 days.
// +
// = 100% Of the Token is distributed to the users! No dev fee or premine!
//
//
// Symbol: zkBTC
// Decimals: 18
//
// Total supply: 52,500,001.000000000000000000
//   =
// 21,000,000 zkBitcoin Tokens go to Liquidity Providers of the token over 100+ year using Bitcoin distribution!  Helps prevent LP losses!  Uses the zkBitcoinStaking0xBTC & zkBitcoinStakingETH Contract!
//   +
// 21,000,000 Mined over 100+ years using Bitcoins Distrubtion halvings every ~3.33 years @ 360 min solves. Uses Proof-oF-Work to distribute the tokens. Public Miner is available.  Uses this contract.
//   +
// 10,500,000 Auctioned over 100+ years into 4 day auctions split fairly among all buyers. ALL Ethereum proceeds go into THIS contract which it fairly distributes to miners and stakers.  Uses the zkBitcoinAuctions contract
//  
//
// ~50% of the Ethereum from this contract goes to the Miner to pay for the transaction cost and if the token grows enough earn Ethereum per mint!
// ~50% of the Ethereum from this contract goes to the Liquidity Providers via zkBTCRewards Contract.  Helps prevent Impermant Loss! Larger Liquidity!
//
// No premine, dev cut, or advantage taken at launch. Public miner available at launch. 100% of the token is given away fairly over 100+ years using Bitcoins model!
//
// Send this contract any ERC20 token and it will become instantly mineable and able to distribute using proof-of-work!
// Donate this contract any NFT and we will also distribute it via Proof of Work to our miners!  
//  
//* 1 token were burned to create the LP pool.
//
// Credits: 0xBitcoin, Vether, Synethix, ABAS


pragma solidity ^0.8.11;

import "./draft-ERC20Permit.sol";

contract Ownable {
    address public owner;

    event TransferOwnership(address _from, address _to);

    constructor() {
        owner = msg.sender;
        emit TransferOwnership(address(0), msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function setOwner(address _owner) internal onlyOwner {
        emit TransferOwnership(owner, _owner);
        owner = _owner;
    }
}

pragma solidity >=0.4.21 <0.9.0;



library IsContract {
    function isContract(address _addr) internal view returns (bool) {
        bytes32 codehash;
        /* solium-disable-next-line */
        assembly { codehash := extcodehash(_addr) }
        return codehash != bytes32(0) && codehash != bytes32(0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470);
    }
}

// File: contracts/utils/SafeMath.sol

library SafeMath2 {
    function add(uint256 x, uint256 y) internal pure returns (uint256) {
        uint256 z = x + y;
        require(z >= x, "Add overflow");
        return z;
    }

    function sub(uint256 x, uint256 y) internal pure returns (uint256) {
        require(x >= y, "Sub underflow");
        return x - y;
    }

    function mult(uint256 x, uint256 y) internal pure returns (uint256) {
        if (x == 0) {
            return 0;
        }

        uint256 z = x * y;
        require(z / x == y, "Mult overflow");
        return z;
    }

    function div(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y != 0, "Div by zero");
        return x / y;
    }

    function divRound(uint256 x, uint256 y) internal pure returns (uint256) {
        require(y != 0, "Div by zero");
        uint256 r = x / y;
        if (x % y != 0) {
            r = r + 1;
        }

        return r;
    }
}

// File: contracts/utils/Math.sol

library ExtendedMath2 {


    //return the smaller of the two inputs (a or b)
    function limitLessThan(uint a, uint b) internal pure returns (uint c) {

        if(a > b) return b;

        return a;

    }
}

// File: contracts/interfaces/IERC20.sol




interface IERC721 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {safeTransferFrom} whenever possible.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

//Recieve NFTs
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be reverted.
     *
     * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}
//Main contract


interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

interface IERC1155 is IERC165 {
    /**
     * @dev Emitted when `value` tokens of token type `id` are transferred from `from` to `to` by `operator`.
     */
    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);

    /**
     * @dev Equivalent to multiple {TransferSingle} events, where `operator`, `from` and `to` are the same for all
     * transfers.
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     *
     * If an {URI} event was emitted for `id`, the standard
     * https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[guarantees] that `value` will equal the value
     * returned by {IERC
     5MetadataURI-uri}.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the amount of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {balanceOf}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(address[] calldata accounts, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);

    /**
     * @dev Grants or revokes permission to `operator` to transfer the caller's tokens, according to `approved`,
     *
     * Emits an {ApprovalForAll} event.
     *
     * Requirements:
     *
     * - `operator` cannot be the caller.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns true if `operator` is approved to transfer ``account``'s tokens.
     *
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(address account, address operator) external view returns (bool);

    /**
     * @dev Transfers `amount` tokens of token type `id` from `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `amount`.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) external;

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {safeTransferFrom}.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `amounts` must have the same length.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
}
interface IERC1155Receiver is IERC165 {
    /**
     * @dev Handles the receipt of a single ERC1155 token type. This function is
     * called at the end of a `safeTransferFrom` after the balance has been updated.
     *
     * NOTE: To accept the transfer, this must return
     * `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
     * (i.e. 0xf23a6e61, or its own function selector).
     *
     * @param operator The address which initiated the transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param id The ID of the token being transferred
     * @param value The amount of tokens being transferred
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
     */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev Handles the receipt of a multiple ERC1155 token types. This function
     * is called at the end of a `safeBatchTransferFrom` after the balances have
     * been updated.
     *
     * NOTE: To accept the transfer(s), this must return
     * `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
     * (i.e. 0xbc197c81, or its own function selector).
     *
     * @param operator The address which initiated the batch transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param ids An array containing ids of each token being transferred (order and length must match values array)
     * @param values An array containing amounts of each token being transferred (order and length must match ids array)
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` if transfer is allowed
     */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}

contract zkBTCAuctionsCT{
    uint256 public totalAuctioned;
    }
    

contract zkBitcoin is Ownable, ERC20Permit {

    function onERC721Received(address, address, uint256, bytes calldata) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }
    
    function onERC1155Received(address, address, uint256, uint256, bytes calldata) external pure returns (bytes4){
	return IERC1155Receiver.onERC1155Received.selector;
	}	
    function onERC1155BatchReceived(address, address, uint256, uint256, bytes calldata) external pure returns (bytes4){
	return IERC1155Receiver.onERC1155Received.selector;
	}
	
	
    uint public targetTime = 60 * 12;
// SUPPORTING CONTRACTS
    address public AddressAuction;
    zkBTCAuctionsCT public AuctionsCT;
    address public AddressLPReward;
    address public AddressLPReward2;
//Events
    using SafeMath2 for uint256;
    using ExtendedMath2 for uint;
    event Mint(address indexed from, uint reward_amount, uint epochCount, bytes32 newChallengeNumber);
    event MegaMint(address indexed from, uint epochCount, bytes32 newChallengeNumber, uint NumberOfTokensMinted, uint256 TokenMultipler);

// Managment events
    mapping(bytes32 => bytes32) public solutionForChallenge;
    bytes32 private constant BALANCE_KEY = keccak256("balance");
    //BITCOIN INITALIZE Start
	
    uint constant _totalSupply = 21000000000000000000000000;
    uint public latestDifficultyPeriodStarted2 = block.timestamp; //BlockTime of last readjustment
    uint public epochCount = 0;//number of 'blocks' mined
    uint public latestreAdjustStarted = block.timestamp; // shorter blocktime of attempted readjustment
    uint public _BLOCKS_PER_READJUSTMENT = 16; // should be 1024
    //a little number
    
    uint public  _MAXIMUM_TARGET = 2**234;
    uint public  _MINIMUM_TARGET = (_MAXIMUM_TARGET).div(1369292849); // Max 10 TH/s of difficulty = 1369292849 @ 12 min
    uint public miningTarget = _MAXIMUM_TARGET.div(200);  //500 difficulty to start
    
    bytes32 public challengeNumber = blockhash(block.number - 1); //generate a new one when a new reward is minted
    uint public rewardEra = 0;
    uint public maxSupplyForEra = (_totalSupply - _totalSupply.div( 2**(rewardEra + 1)));
    uint public reward_amount = 2;
    
    //Stuff for Functions
    uint public oldecount = 0; //Previous block count for ArewardSender function
    uint public previousBlockTime  =  block.timestamp; // Previous Blocktime
    uint public Token2Per=           1000000; //Amount of ETH distributed per mint somewhat
    uint public tokensMinted = 0;			//Tokens Minted only for Miners
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;
    uint public slowBlocks = 0;
    uint public epochOld = 0;  //Epoch count at each readjustment 
    uint public give0x = 0;
    uint public give = 1;
    uint public lastTokensMinted = 0;
    uint public multipler = 0;
    // metadata
	
    uint256 lastrun = block.timestamp;
    uint public latestDifficultyPeriodStarted = block.number;
    bool initeds = false;
    uint startTime = 0;
    bool locked = false;
    

	// mint 1 token to setup LPs
	constructor() ERC20("zkBitcoin", "zkBTC") ERC20Permit("zkBitcoin") {
		_mint(msg.sender, 1000000000000000000);

		startTime = block.timestamp;  //On GMT: Thursday, September 14, 2023 6:00:00 PM

		reward_amount = 0;  //Zero reward for first days to setup miners
		rewardEra = 0;
		tokensMinted = 0;
		epochCount = 0;
		epochOld = 0;
		miningTarget = _MAXIMUM_TARGET.div(1);
		latestDifficultyPeriodStarted2 = block.timestamp;
		latestDifficultyPeriodStarted = block.number;
	}


	function zinit(address AuctionAddress2, address LPGuild) public onlyOwner{
		uint x = 21000000000000000000000000; 
		// Only init once
		assert(!initeds);
    		lastrun = block.timestamp;
		initeds = true;
		previousBlockTime = block.timestamp;
		reward_amount = 0;
	    	rewardEra = 0;
		tokensMinted = 0;
		multipler = address(this).balance / (1 * 10 ** 18); 	
		Token2Per = (2** rewardEra) * address(this).balance / (250000 + 250000*(multipler)); //aimed to give about 400 days of reserves

	    	miningTarget = _MAXIMUM_TARGET.div(1);
	    	_startNewMiningEpoch();

		epochCount = 0;
		epochOld = 0;
		latestDifficultyPeriodStarted2 = block.timestamp;
		previousBlockTime = block.timestamp;
    		lastrun = block.timestamp;
		// Init contract variables and mint
		 _mint(AuctionAddress2, x/2);

	    	AddressAuction = AuctionAddress2;
		AuctionsCT = zkBTCAuctionsCT(AddressAuction);
		AddressLPReward = payable(LPGuild);
		AddressLPReward2 = payable(LPGuild);
		slowBlocks = 1;
		oldecount = epochCount;
		
		setOwner(address(0));
     
  	}



	function zinit2(address AuctionAddress2, address LPGuild, address LPGuild2) public onlyOwner{
		uint x = 21000000000000000000000000; 
		// Only init once
		assert(!initeds);
    		lastrun = block.timestamp;
		initeds = true;
		previousBlockTime = block.timestamp;
		reward_amount = 0;
	    	rewardEra = 0;
		tokensMinted = 0;
		multipler = address(this).balance / (1 * 10 ** 18); 	
		Token2Per = (2** rewardEra) * address(this).balance / (250000 + 250000*(multipler)); //aimed to give about 400 days of reserves

	    	miningTarget = _MAXIMUM_TARGET.div(1);
	    	_startNewMiningEpoch();

		epochCount = 0;
		epochOld = 0;
		latestDifficultyPeriodStarted2 = block.timestamp;
		previousBlockTime = block.timestamp;
    		lastrun = block.timestamp;
		// Init contract variables and mint
		 _mint(AuctionAddress2, x/2);

	    	AddressAuction = AuctionAddress2;
		AuctionsCT = zkBTCAuctionsCT(AddressAuction);
		AddressLPReward = payable(LPGuild);
		AddressLPReward2 = payable(LPGuild2);
		slowBlocks = 1;
		oldecount = epochCount;
		
		setOwner(address(0));
     
  	}



	//////////////////////////////////
	// Contract Initialize Function //
	//////////////////////////////////


	function openMining() public returns (bool success) {
		//Starts mining after a few days period for miners to setup is done
		require(!locked, "Only allowed to run once");
		locked = true;
		require(block.timestamp >= startTime && block.timestamp <= startTime + 60* 60 * 24* 7, "Must wait until after startTime (Sept 14th 2023 @ 6PM GMT)");
		latestDifficultyPeriodStarted2 = block.timestamp;
		previousBlockTime = block.timestamp;		
		reward_amount = 30 * 10**18;
		rewardEra = 0;
		tokensMinted = 0;
		epochCount = 0;
		epochOld = 0;
		lastrun = block.timestamp;
		miningTarget = _MAXIMUM_TARGET.div(2000);
		latestDifficultyPeriodStarted2 = block.timestamp;
		latestDifficultyPeriodStarted = block.number;
		
		return true;
	}


	///
	// Managment
	///

	function ARewardSender() public {
		//runs every _BLOCKS_PER_READJUSTMENT / 8

		uint zkBTCtoSend = (tokensMinted - lastTokensMinted).div(2);

		multipler = address(this).balance / (1 * 10 ** 18); 	
		Token2Per = (2** rewardEra) * address(this).balance / (250000 + 250000*(multipler)); //aimed to give about 400 days of reserves

		uint256 runs = block.timestamp - lastrun;

		uint256 epochsPast = epochCount - oldecount; //actually epoch
		uint256 runsperepoch = runs / epochsPast;
		
		uint256 x = (runsperepoch * 888).divRound(targetTime);
		uint256 ratio = x * 100 / 888;
		uint256 totalOwed;
		
		 if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
		 }else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
		} 

        	_mint(AddressLPReward, zkBTCtoSend );
        	_mint(AddressLPReward2,  zkBTCtoSend);

		if( address(this).balance > (200 * (Token2Per * _BLOCKS_PER_READJUSTMENT)/4)){  // at least enough blocks to rerun this function for both LPRewards and Users
			address payable to = payable(AddressLPReward);
			address payable to2 = payable(AddressLPReward2);
			uint toSendAmt = ((epochsPast) * totalOwed * Token2Per * give0x).div(100000000);
			
			if(ratio > 2000){
				toSendAmt = ((epochsPast) * 320 * Token2Per * give0x).div(10*2);
			}

			payable(to).call{value: toSendAmt}("");
           		payable(to2).call{value: toSendAmt}("");
           		give0x = 1 * give;
		}else{
			give0x = 0;
		}
		
		oldecount = epochCount; //actually epoch

		lastrun = block.timestamp;
		lastTokensMinted = tokensMinted;
	}


	//compatibility function
	function mint(uint256 nonce, bytes32 challenge_digest) public payable returns (bool success) {
		mintTo(nonce, challenge_digest, msg.sender);
		return true;
	}
	


	///
	// NFT Minting
	///


	function mintNFTGOBlocksUntil() public view returns (uint num) {
		return _BLOCKS_PER_READJUSTMENT/8 - (slowBlocks % (_BLOCKS_PER_READJUSTMENT/8 ));
	}
	


	function mintNFTGO() public view returns (uint num) {
		return slowBlocks % (_BLOCKS_PER_READJUSTMENT/8);
	}
	

	function mintNFT721(address nftaddy, uint nftNumber, uint256 nonce, bytes32 challenge_digest) public returns (bool success) {
		require(mintNFTGO() == 0, "Only mint on slowBlocks % _BLOCKS_PER_READJUSTMENT/8 == 0");
		mintTo(nonce, challenge_digest, msg.sender);
		IERC721(nftaddy).safeTransferFrom(address(this), msg.sender, nftNumber, "");
		if(mintNFTGO() == 0){
			slowBlocks = slowBlocks.add(1);
		}
		return true;
	}



	function mintNFT1155(address nftaddy, uint nftNumber, uint256 nonce, bytes32 challenge_digest) public returns (bool success) {
		require(mintNFTGO() == 0, "Only mint on slowBlocks % _BLOCKS_PER_READJUSTMENT/8 == 0");
		mintTo(nonce, challenge_digest, msg.sender);
		IERC1155(nftaddy).safeTransferFrom(address(this), msg.sender, nftNumber, 1, "" );
		if(mintNFTGO() == 0){
			slowBlocks = slowBlocks.add(1);
		}
		return true;
	}


	///
	// Minting
	///



	function mintTo(uint256 nonce, bytes32 challenge_digest, address mintToAddress) public payable returns (uint256 totalOwed) {

		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		//the challenge digest must match the expected
		require(digest == challenge_digest, "Old challenge_digest or wrong challenge_digest");

		//the digest must be smaller than the target
		require(uint256(digest) < miningTarget, "Digest must be smaller than miningTarget");

             	solutionForChallenge[challengeNumber] = digest;

		_startNewMiningEpoch();

		//uint diff = block.timestamp - previousBlockTime;
		uint256 x = ((block.timestamp - previousBlockTime) * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
	
		
		if(ratio > 100){
			
			slowBlocks = slowBlocks.add(1);
			
		}
		
		//best @ 3000 ratio totalOwed / 100000000 = 71.6
		if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
			require(msg.value >= ((1 * 10**15) / (((ratio+10)/10) *2) ), "Must send more ETH because requires eth, check howMuchETH() function to find amount needed");
		}else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
			if(ratio < 6000){
				uint ratioETH = ratio - 2995;
				require(msg.value >= ((1 * 10**15) / ( ((ratioETH+10) / 10) * 500)), "Must send more ETH because requires eth until 60x targetTime, check howMuchETH() function to find amount needed");
			}
		}

		uint totalOwedABAS = (reward_amount * totalOwed).div(100000000);
		
		
        	_mint(mintToAddress, totalOwedABAS);
		
		tokensMinted = tokensMinted.add(totalOwedABAS);
		previousBlockTime = block.timestamp;
		if(give0x > 0){
			if(ratio < 2000){
            			address payable to = payable(mintToAddress);
				payable(to).call{value: ((totalOwed * Token2Per * give0x).div(100000000)) }("");  
             		}else{
               			address payable to = payable(mintToAddress); 
				payable(to).call{value: ((320 * Token2Per * give0x).div(10)) }("");  
			}
		}

		emit Mint(mintToAddress, totalOwedABAS, epochCount, challengeNumber );

		return totalOwed;

	}



	function howMuchETHatTime(uint secondsBetweenEpoch) public view returns (uint totalETHNeeded){
		uint256 x = ((secondsBetweenEpoch) * 888) / targetTime;
		uint ratio = x * 100 / 888;
		
		
		if(ratio >= 3000){
			if(ratio < 6000){
				ratio = ratio - 2995;
				return ((1 * 10**15) / (((ratio+7) / 10) * 500)) ;
			}
			return 0;
		}else if(ratio > 18){
			//A Little behind so we dont bump into error on mint.
			ratio = ratio - 3;
		}
		return (1 * 10**15 / (((ratio+10)/10)*2));
	}


	//A Little ahead so we dont bump into error.
	function howMuchETH() public view returns (uint totalETHNeeded){
		return howMuchETHatTime((block.timestamp - previousBlockTime));
	}


	
	function YourETHBalance() public view returns( uint urTotalETHInWallet){
		return (msg.sender).balance;
	}



	function mintToJustABAS(uint256 nonce, bytes32 challenge_digest, address mintToAddress) public payable returns (uint256 totalOwed) {

		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		//the challenge digest must match the expected
		require(digest == challenge_digest, "Old challenge_digest or wrong challenge_digest");

		//the digest must be smaller than the target
		require(uint256(digest) < miningTarget, "Digest must be smaller than miningTarget");

             	solutionForChallenge[challengeNumber] = digest;

		_startNewMiningEpoch();

		//uint diff = block.timestamp - previousBlockTime;
		uint256 x = ((block.timestamp - previousBlockTime) * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
		
		
		if(ratio > 100){
			
			slowBlocks = slowBlocks.add(1);
			
		}
		
		//best @ 3000 ratio totalOwed / 100000000 = 71.6
		if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
			require(msg.value >= ((1 * 10**15) / (((ratio+10)/10) *2)), "Must send more ETH because requires eth, check howMuchETH() function to find amount needed");
		}else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
			if(ratio < 6000){
				ratio = ratio - 2995;
				require(msg.value >= ((1 * 10**15) / (((ratio+10) / 10) * 500)), "Must send more ETH because requires eth until 60x targetTime, check howMuchETH() function to find amount needed");
			}
		}

		uint totalOwedABAS = (reward_amount * totalOwed).div(100000000);
		
		
        	_mint(mintToAddress, totalOwedABAS);
		
		tokensMinted = tokensMinted.add(totalOwedABAS);
		previousBlockTime = block.timestamp;

		emit Mint(mintToAddress, totalOwedABAS, epochCount, challengeNumber );

		return totalOwed;

	}



	function mintTokensArrayTo(uint256 nonce, bytes32 challenge_digest, address[] memory ExtraFunds, address[] memory MintTo) public payable returns (uint256 owedzz) {
		uint256 totalOd = mintTo(nonce,challenge_digest, MintTo[0]);
		require(totalOd > 0, "mint issue");

		require(MintTo.length == ExtraFunds.length + 1,"MintTo has to have an extra address compared to ExtraFunds");
		uint xy=0;
		for(xy = 0; xy< ExtraFunds.length; xy++)
		{
			if(epochCount % (2**(xy+1)) != 0){
				break;
			}
			for(uint y=xy+1; y< ExtraFunds.length; y++){
				require(ExtraFunds[y] != ExtraFunds[xy], "No printing The same tokens");
			}
		}
		
		uint TotalOwned = 0;
		uint totalToSend = 0;
		for(uint x=0; x<xy; x++)
		{
			//epoch count must evenly dividable by 2^n in order to get extra mints. 
			//ex. epoch 2 = 1 extramint, epoch 4 = 2 extra, epoch 8 = 3 extra mints, ..., epoch 32 = 5 extra mints w/ a divRound for the 5th mint(allows small balance token minting aka NFTs)
			if(epochCount % (2**(x+1)) == 0){
				TotalOwned = IERC20(ExtraFunds[x]).balanceOf(address(this));
				if(TotalOwned != 0){
					if( x % 3 == 0 && x != 0 && totalOd > 17600000){
						totalToSend = ( (2** rewardEra) *TotalOwned * totalOd).divRound(100000000 * 20000);
						
					}else{
						totalToSend = ( (2** rewardEra) * TotalOwned * totalOd).div(100000000 * 20000);
					}
				}
			    	IERC20(ExtraFunds[x]).transfer(MintTo[x+1], totalToSend);
			}
			totalToSend = 0;
		}
        	
        	
		emit MegaMint(msg.sender, epochCount, challengeNumber, xy, totalOd );

		return totalOd;

	}



	function mintTokensSameAddress(uint256 nonce, bytes32 challenge_digest, address[] memory ExtraFunds, address MintTo) public payable returns (bool success) {
		address[] memory dd = new address[](ExtraFunds.length + 1); 

		for(uint x=0; x< (ExtraFunds.length + 1); x++)
		{
			dd[x] = MintTo;
		}
		
		mintTokensArrayTo(nonce, challenge_digest, ExtraFunds, dd);

		return true;
	}



	function empty_mintTo(uint256 nonce, bytes32 challenge_digest, address[] memory ExtraFunds, address[] memory MintTo) public payable returns (uint256 owed) {
		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		//the challenge digest must match the expected
		require(digest == challenge_digest, "Old challenge_digest or wrong challenge_digest");

		//the digest must be smaller than the target
		require(uint256(digest) < miningTarget, "Digest must be smaller than miningTarget");

             	solutionForChallenge[challengeNumber] = digest;

		_startNewMiningEpoch();

		require(MintTo.length == ExtraFunds.length,"MintTo has to have same number of addressses as ExtraFunds");
		
		require(uint256(digest) < (miningTarget), "Digest must be smaller than miningTarget");
		uint xy=0;
		for(xy = 0; xy< ExtraFunds.length; xy++)
		{
			if(epochCount % (2**(xy+1)) != 0){
				break;
			}
			for(uint y=xy+1; y< ExtraFunds.length; y++){
				require(ExtraFunds[y] != ExtraFunds[xy], "No printing The same tokens");
			}
		}

		uint256 x = ((block.timestamp - previousBlockTime) * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
		uint totalOwed = 0;

		
		if(ratio > 100){
			
			slowBlocks = slowBlocks.add(1);
			
		}

		if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
			require(msg.value >= ((1 * 10**15) / (((ratio+10)/10) *2)), "Must send more ETH because requires eth, check howMuchETH() function to find amount needed");
		}else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
			if(ratio < 6000){
				ratio = ratio - 2995;
				require(msg.value >= ((1 * 10**15) / (((ratio+10) / 10) * 500)), "Must send more ETH because requires eth until 60x targetTime, check howMuchETH() function to find amount needed");
			}
		}


		uint256 TotalOwned;
		uint totalToSend = 0;
		for(uint z=0; z<xy; z++)
		{
			//epoch count must evenly dividable by 2^n in order to get extra mints. 
			//ex. epoch 2 = 1 extramint, epoch 4 = 2 extra, epoch 8 = 3 extra mints, epoch 16 = 4 extra mints w/ a divRound for the 4th mint(allows small balance token minting aka NFTs)
			if(epochCount % (2**(x+1)) == 0){
				TotalOwned = IERC20(ExtraFunds[x]).balanceOf(address(this));
				if(TotalOwned != 0){
					if( x % 3 == 0 && x != 0 && totalOwed > 17600000 ){
						totalToSend = ( (2** rewardEra) * TotalOwned * totalOwed).divRound(100000000 * 20000);
					}else{
						totalToSend = ( (2** rewardEra) * TotalOwned * totalOwed).div(100000000 * 20000 );
				    	}
			    	IERC20(ExtraFunds[x]).transfer(MintTo[x], totalToSend);

           			}
       			}
			totalToSend = 0;
		}
		previousBlockTime = block.timestamp;
		return totalOwed;   
	}



	function timeFromLastSolve() public view returns (uint256 time){
		time = block.timestamp - previousBlockTime;
		return time;
	}



	function rewardAtCurrentTime() public view returns (uint256 reward){
		uint256 x = (block.timestamp - previousBlockTime);
		reward = rewardAtTime(x);
		return reward;
	}


	
	function rewardAtTime(uint timeDifference) public view returns (uint256 rewards){
		uint256 x = (timeDifference * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
		uint totalOwed = 0;


		//best @ 3000 ratio totalOwed / 100000000 = 71.6
		if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
		}else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
		}

		rewards = (reward_amount * totalOwed).div(100000000);

		return rewards;
	}

	
	function rewardAtTimeTokenBase(uint timeDifference, address RewardToken) public view returns (uint256 rewards){
		uint256 x = (timeDifference * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
		uint totalOwed = 0;


		//best @ 3000 ratio totalOwed / 100000000 = 71.6
		if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
		}else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
		}

		uint totalToSend = 0;
		IERC20 erc20Token = IERC20(address(RewardToken));

		uint TotalOwned = erc20Token.balanceOf(address(this));
			if(totalOwed > 17600000 ){
				totalToSend = ( (2** rewardEra) * TotalOwned * totalOwed).divRound(100000000 * 20000);
			}else{
				totalToSend = ( (2** rewardEra) * TotalOwned * totalOwed).div(100000000 * 20000 );
			}
		return totalToSend;
	}

	
	function rewardAtTimeETHRewards(uint timeDifference) public view returns (uint256 rewardOfETH){
		uint256 x = (timeDifference * 888) / targetTime;
		uint ratio = x * 100 / 888 ;
		uint totalOwed = 0;

		
		//best @ 3000 ratio totalOwed / 100000000 = 71.6
		if(ratio < 3000){
			totalOwed = (508606*(15*x**2)).div(888 ** 2)+ (9943920 * (x)).div(888);
		}else {
			totalOwed = (24*x*5086060).div(888)+3456750000;
		}
		uint toSendAmt = (totalOwed * Token2Per * give0x).div(100000000);
			
		if(ratio > 2000){
			toSendAmt = (320 * Token2Per * give0x).div(10);
		}

		return toSendAmt;

	}


	function blocksFromReadjust() public view returns (uint256 blocks){
		blocks = (epochCount - epochOld);
		return blocks;
	}
	


	function blocksToReadjust() public view returns (uint blocks){
		if((epochCount - epochOld) == 0){
			if(give == 1){
				return (_BLOCKS_PER_READJUSTMENT);
			}else{
				return (_BLOCKS_PER_READJUSTMENT / 8);
			}
		}
		uint256 blktimestamp = block.timestamp;
		uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestreAdjustStarted;
		uint adjusDiffTargetTime = targetTime * ((epochCount - epochOld) % (_BLOCKS_PER_READJUSTMENT/8)); 

		if( TimeSinceLastDifficultyPeriod2 > adjusDiffTargetTime)
		{
				blocks = _BLOCKS_PER_READJUSTMENT/8 - ((epochCount - epochOld) % (_BLOCKS_PER_READJUSTMENT/8));
				return (blocks);
		}else{
			    blocks = _BLOCKS_PER_READJUSTMENT - ((epochCount - epochOld) % _BLOCKS_PER_READJUSTMENT);
			    return (blocks);
		}
	
	}



	function _startNewMiningEpoch() internal {


		//if max supply for the era will be exceeded next reward round then enter the new era before that happens
		//59 is the final reward era, almost all tokens minted
		if( tokensMinted.add(reward_amount) > maxSupplyForEra && rewardEra < 59)
		{
			rewardEra = rewardEra + 1;
			maxSupplyForEra = _totalSupply - _totalSupply.div( 2**(rewardEra + 1));
			if(rewardEra < 8){
                    		_MINIMUM_TARGET = _MINIMUM_TARGET / 2;
				targetTime = ((12 * 60) * 2**rewardEra);

				if(rewardEra < 6){
					if(_BLOCKS_PER_READJUSTMENT <= 16){
						_BLOCKS_PER_READJUSTMENT = 8;
					}else{
						_BLOCKS_PER_READJUSTMENT = _BLOCKS_PER_READJUSTMENT / 2;
					}
				}
			}else{

				reward_amount = ( 30 * 10**18)/( 2**(rewardEra - 7  ) );
			}
		}

		//set the next minted supply at which the era will change
		// total supply of MINED tokens is 21000000000000000000000000  because of 18 decimal places

		epochCount = epochCount.add(1);

		//every so often, readjust difficulty. Dont readjust when deploying
		if((epochCount - epochOld) % (_BLOCKS_PER_READJUSTMENT / 8) == 0)
		{
			ARewardSender();
			if(_totalSupply < tokensMinted){
				reward_amount = 0;
			}
			
			uint256 blktimestamp = block.timestamp;
			uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestreAdjustStarted;
			uint adjusDiffTargetTime = targetTime *  (_BLOCKS_PER_READJUSTMENT / 8) ; 
			latestreAdjustStarted = block.timestamp;

			if( TimeSinceLastDifficultyPeriod2 > adjusDiffTargetTime || (epochCount - epochOld) % _BLOCKS_PER_READJUSTMENT == 0) 
			{
				_reAdjustDifficulty();
			}
		}

		challengeNumber = blockhash(block.number - 1);
		bytes32 solution = solutionForChallenge[challengeNumber];
		if(solution != 0x0) revert();  //prevent the same answer from awarding twice
 	}



	function reAdjustsToWhatDifficulty() public view returns (uint difficulty) {
		if(epochCount - epochOld == 0){
			return _MAXIMUM_TARGET.div(miningTarget);
		}

		uint256 blktimestamp = block.timestamp;
		uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestDifficultyPeriodStarted2;
		uint epochTotal = epochCount - epochOld;
		uint adjusDiffTargetTime = targetTime *  epochTotal; 
        	uint miningTarget2 = 0;

		//if there were less eth blocks passed in time than expected
		if( TimeSinceLastDifficultyPeriod2 < adjusDiffTargetTime )
		{
			uint excess_block_pct = (adjusDiffTargetTime.mult(100)).div( TimeSinceLastDifficultyPeriod2 );
			uint excess_block_pct_extra = excess_block_pct.sub(100).limitLessThan(1000);
			//make it harder 
			miningTarget2 = miningTarget.sub(miningTarget.div(2000).mult(excess_block_pct_extra));   //by up to 50 %
		}else{
			uint shortage_block_pct = (TimeSinceLastDifficultyPeriod2.mult(100)).div( adjusDiffTargetTime );

			uint shortage_block_pct_extra = shortage_block_pct.sub(100).limitLessThan(1000); //always between 0 and 1000
			//make it easier
			miningTarget2 = miningTarget.add(miningTarget.div(500).mult(shortage_block_pct_extra));   //by up to 200 %
		}

		if(miningTarget2 < _MINIMUM_TARGET) //very difficult
		{
			miningTarget2 = _MINIMUM_TARGET;
		}
		if(miningTarget2 > _MAXIMUM_TARGET) //very easy
		{
			miningTarget2 = _MAXIMUM_TARGET;
		}
		difficulty = _MAXIMUM_TARGET.div(miningTarget2);
			return difficulty;
	}



	function _reAdjustDifficulty() internal {
		uint256 blktimestamp = block.timestamp;
		uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestDifficultyPeriodStarted2;
		uint epochTotal = epochCount - epochOld;
		uint adjusDiffTargetTime = targetTime *  epochTotal; 
		epochOld = epochCount;

		//if there were less eth blocks passed in time than expected
		if( TimeSinceLastDifficultyPeriod2 < adjusDiffTargetTime )
		{
			uint excess_block_pct = (adjusDiffTargetTime.mult(100)).div( TimeSinceLastDifficultyPeriod2 );
			give = 1;
			uint excess_block_pct_extra = excess_block_pct.sub(100).limitLessThan(1000);
			//make it harder 
			miningTarget = miningTarget.sub(miningTarget.div(2000).mult(excess_block_pct_extra));   //by up to 2x
		}else{
			uint shortage_block_pct = (TimeSinceLastDifficultyPeriod2.mult(100)).div( adjusDiffTargetTime );
			give = 2;
			uint shortage_block_pct_extra = shortage_block_pct.sub(100).limitLessThan(1000); //always between 0 and 1000
			//make it easier
			miningTarget = miningTarget.add(miningTarget.div(500).mult(shortage_block_pct_extra));   //by up to 4x
		}

		latestDifficultyPeriodStarted2 = blktimestamp;
		latestDifficultyPeriodStarted = block.number;

		if(miningTarget < _MINIMUM_TARGET) //very difficult
		{
			miningTarget = _MINIMUM_TARGET;
		}
		if(miningTarget > _MAXIMUM_TARGET) //very easy
		{
			miningTarget = _MAXIMUM_TARGET;
		}
		
	}


	//Stat Functions

	function inflationMined () public view returns (uint YearlyInflation, uint EpochsPerYear, uint RewardsAtTime, uint TimePerEpoch){
		if(epochCount - epochOld == 0){
			return (0, 0, 0, 0);
		}
		uint256 blktimestamp = block.timestamp;
		uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestDifficultyPeriodStarted2;

        
		TimePerEpoch = TimeSinceLastDifficultyPeriod2 / blocksFromReadjust(); 
		RewardsAtTime = rewardAtTime(TimePerEpoch);
		uint year = 365 * 24 * 60 * 60;
		EpochsPerYear = year / TimePerEpoch;
		YearlyInflation = RewardsAtTime * EpochsPerYear;
		return (YearlyInflation, EpochsPerYear, RewardsAtTime, TimePerEpoch);
	}

	

	function toNextEraDays () public view returns (uint daysToNextEra, uint _maxSupplyForEra, uint _tokensMinted, uint amtDaily){

        (uint totalamt,,,) = inflationMined();
		(amtDaily) = totalamt / 365;
		if(amtDaily == 0){
			return(0,0,0,0);
		}
		daysToNextEra = (maxSupplyForEra - tokensMinted) / amtDaily;
		return (daysToNextEra, maxSupplyForEra, tokensMinted, amtDaily);
	}
	


	function toNextEraEpochs () public view returns ( uint epochs, uint epochTime, uint daysToNextEra){
		if(blocksFromReadjust() == 0){
			return (0,0,0);
        }
		uint256 blktimestamp = block.timestamp;
        uint TimeSinceLastDifficultyPeriod2 = blktimestamp - latestDifficultyPeriodStarted2;
		uint timePerEpoch = TimeSinceLastDifficultyPeriod2 / blocksFromReadjust();
		(uint daysz,,,) = toNextEraDays();
		uint amt = daysz * (60*60*24) / timePerEpoch;
		return (amt, timePerEpoch, daysz);
	}


	//help debug mining software
	function checkMintSolution(uint256 nonce, bytes32 challenge_digest, bytes32 challenge_number, uint testTarget) public view returns (bool success) {
		bytes32 digest = bytes32(keccak256(abi.encodePacked(challenge_number,msg.sender,nonce)));
		if(uint256(digest) > testTarget) revert();

		return (digest == challenge_digest);
	}


	//help debug mining software2
	function checkMintSolution2(uint256 nonce, bytes32 challenge_digest, bytes32 challenge_number, uint testTarget, address senda) public view returns (bytes32 success) {
		bytes32 digest = bytes32(keccak256(abi.encodePacked(challenge_number,senda,nonce)));
		if(uint256(digest) > testTarget) revert();

		return digest;
	}


	//this is a recent ethereum block hash, used to prevent pre-mining future blocks
	function getChallengeNumber() public view returns (bytes32) {

		return challengeNumber;

	}

	
	//the number of zeroes the digest of the PoW solution requires.  Auto adjusts
	function getMiningDifficulty() public view returns (uint) {
			return _MAXIMUM_TARGET.div(miningTarget);
	}


	function getMiningTarget() public view returns (uint) {
			return (miningTarget);
	}



	function getMiningMinted() public view returns (uint) {
		return tokensMinted;
	}



	function getCirculatingSupply() public view returns (uint) {
		return tokensMinted * 2 + AuctionsCT.totalAuctioned();
	}
	
	//21m coins total
	//reward begins at 150 and is cut in half every reward era (as tokens are mined)
	function getMiningReward() public view returns (uint) {
		//once we get half way thru the coins, only get 25 per block
		//every reward era, the reward amount halves.

		if(rewardEra < 8){
			return ( 30 * 10**18);
		}else{
			return ( 30 * 10**18)/( 2**(rewardEra - 7  ) );
		}
	}



	function getEpoch() public view returns (uint) {

		return epochCount ;

	}


	//help debug mining software
	function getMintDigest(uint256 nonce, bytes32 challenge_digest, bytes32 challenge_number) public view returns (bytes32 digesttest) {

		bytes32 digest =  keccak256(abi.encodePacked(challengeNumber, msg.sender, nonce));

		return digest;

	}



	  //Allow ETH to enter
	receive() external payable {

	}



	fallback() external payable {

	}

}

/*
*
* MIT License
* ===========
*
* Copyright (c) 2023 Zero Knowledge Bitcoin (zkBTC)
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.   
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
*/

