
// File: bitlime-periphery/contracts/interfaces/IWETH.sol

pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint value) external returns (bool);
    function withdraw(uint) external;
}

// File: bitlime-periphery/contracts/interfaces/IERC20.sol

pragma solidity >=0.5.0;

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}

// File: bitlime-periphery/contracts/libraries/SafeMath.sol

pragma solidity =0.6.6;

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}

// File: bitlime-periphery/contracts/interfaces/IBitlimeV2Pair.sol

pragma solidity >=0.5.0;

interface IBitlimeV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

// File: bitlime-periphery/contracts/interfaces/IBitlimeV2Router01.sol

pragma solidity >=0.6.2;

interface IBitlimeV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress   //Address for our affiliate or white label
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut, address affiliateAddress) external view returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut, address affiliateAddress) external view returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path, address affiliateAddress) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path, address affiliateAddress) external view returns (uint[] memory amounts);
}

// File: bitlime-periphery/contracts/interfaces/IBitlimeV2Router02.sol

pragma solidity >=0.6.2;


interface IBitlimeV2Router02 is IBitlimeV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    ) external;
}

// File: bitlime-periphery/contracts/interfaces/IBitlimeV2Factory.sol

pragma solidity >=0.5.0;

interface IBitlimeV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function fee() external view returns (uint);
    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

// File: bitlime-periphery/contracts/libraries/BitlimeV2Library.sol

pragma solidity >=0.5.0;




//interface SmallIBitlimeV2Factory {
//    function getPair(address tokenA, address tokenB) external view returns (address pair);
//}

library BitlimeV2Library {
    using SafeMath for uint;

    

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'BitlimeV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'BitlimeV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        //pair = SmallIBitlimeV2Factory(factory).getPair(token0,token1);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'944eb2b14015033792e1ba7f7968118c4662629445936ae308dab28021844f28' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB,address PoolAddress) {
        (address token0,) = sortTokens(tokenA, tokenB);
        PoolAddress = pairFor(factory, tokenA, tokenB);
        (uint reserve0, uint reserve1,) = IBitlimeV2Pair(PoolAddress).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
        require(amountA > 0, 'BitlimeV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'BitlimeV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut, address factory) internal view returns (uint amountOut) {
        require(amountIn > 0, 'BitlimeV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'BitlimeV2Library: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(10000-IBitlimeV2Factory(factory).fee());
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(10000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut, address factory) internal view returns (uint amountIn) {
        require(amountOut > 0, 'BitlimeV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'BitlimeV2Library: INSUFFICIENT_LIQUIDITY');
        uint numerator = reserveIn.mul(amountOut).mul(10000);
        uint denominator = reserveOut.sub(amountOut).mul(10000-IBitlimeV2Factory(factory).fee());
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'BitlimeV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[0] = amountIn;
        for (uint i; i < path.length - 1; i++) {
            (uint reserveIn, uint reserveOut,) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut, factory);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
        require(path.length >= 2, 'BitlimeV2Library: INVALID_PATH');
        amounts = new uint[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint i = path.length - 1; i > 0; i--) {
            (uint reserveIn, uint reserveOut,) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut, factory);
        }
    }
}

// File: bitlime-periphery/contracts/libraries/TransferHelper.sol



pragma solidity >=0.6.0;

// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeApprove: approve failed'
        );
    }

    function safeTransfer(
        address token,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::safeTransfer: transfer failed'
        );
    }

    function safeTransferFrom(
        address token,
        address from,
        address to,
        uint256 value
    ) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(
            success && (data.length == 0 || abi.decode(data, (bool))),
            'TransferHelper::transferFrom: transferFrom failed'
        );
    }

    function safeTransferETH(address to, uint256 value) internal {
        (bool success, ) = to.call{value: value}(new bytes(0));
        require(success, 'TransferHelper::safeTransferETH: ETH transfer failed');
    }
}

// File: bitlime-periphery/contracts/BitlimeV2Router02.sol

pragma solidity =0.6.6;








contract BitlimeV2Router02 is IBitlimeV2Router02 {

    mapping(address => address[] ) public AffiliateList;    //This mapping Key is the affiliate address, and the value are the users he brought
    mapping(address => address) public userExists; //This mapping save as a key all existing users, and the relative affiliate (as value)
    address public owner;
    uint public affiliateCommission; //commission set for the affiliate
    mapping(address => uint) public whiteLabelCommission; //commission set by the white label dex admin

    //mapping(address => mapping(address => uint)) public affiliateRanking; //mapping for save coin the coins earned by each affiliate
    //address[] affiliateArray; //this contain an array with the list of affiliates, until now

    using SafeMath for uint;

    event EventPA(address EventAddress);

    address public immutable override factory;
    address public immutable override WETH;

    modifier ensure(uint deadline) {
        require(deadline >= block.timestamp, 'BitlimeV2Router: EXPIRED');
        _;
    }

    constructor(address _factory, address _WETH) public {
        factory = _factory;
        WETH = _WETH;
        owner = msg.sender;
        affiliateCommission = 5;
    }

    receive() external payable {
        assert(msg.sender == WETH); // only accept ETH via fallback from the WETH contract
    }

    //Recommended value is 5, with this function any user can change his white label fee (if his do, become a whitelabel, and can't receive affiliate commission anymore)
    function setWhiteLabelCommission(uint newWhiteLabelCommission) public {
        //note, if the user set 0, the user come back to be an affiliate
        require(newWhiteLabelCommission >= 0, "commission must be positive");
        require(newWhiteLabelCommission <= 1000, "this commission is too high");
        whiteLabelCommission[msg.sender] = newWhiteLabelCommission;
    }

    //admin function to set the affiliateCommission for all affiliate
    function setAffiliateCommission(uint newAffiliateCommission) public {
        require(owner == msg.sender, "Caller is not the owner");
        require(newAffiliateCommission >= 0, "commission must be positive");
        affiliateCommission = newAffiliateCommission;
    }

    function transferOwnership(address newOwner) public {
        require(owner == msg.sender, "Caller is not the owner");
        owner = newOwner;
    }

    // **** ADD LIQUIDITY ****
    function _addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin
    ) internal virtual returns (uint amountA, uint amountB) {
        // create the pair if it doesn't exist yet
        if (IBitlimeV2Factory(factory).getPair(tokenA, tokenB) == address(0)) {
            IBitlimeV2Factory(factory).createPair(tokenA, tokenB);
        }
        (uint reserveA, uint reserveB, address PoolAddress) = BitlimeV2Library.getReserves(factory, tokenA, tokenB);
        emit EventPA(PoolAddress);
        if (reserveA == 0 && reserveB == 0) {
            (amountA, amountB) = (amountADesired, amountBDesired);
        } else {
            uint amountBOptimal = BitlimeV2Library.quote(amountADesired, reserveA, reserveB);
            if (amountBOptimal <= amountBDesired) {
                require(amountBOptimal >= amountBMin, 'BitlimeV2Router: INSUFFICIENT_B_AMOUNT');
                (amountA, amountB) = (amountADesired, amountBOptimal);
            } else {
                uint amountAOptimal = BitlimeV2Library.quote(amountBDesired, reserveB, reserveA);
                assert(amountAOptimal <= amountADesired);
                require(amountAOptimal >= amountAMin, 'BitlimeV2Router: INSUFFICIENT_A_AMOUNT');
                (amountA, amountB) = (amountAOptimal, amountBDesired);
            }
        }
    }
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external virtual override ensure(deadline) returns (uint amountA, uint amountB, uint liquidity) {
        (amountA, amountB) = _addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin);
        address pair = BitlimeV2Library.pairFor(factory, tokenA, tokenB);
        TransferHelper.safeTransferFrom(tokenA, msg.sender, pair, amountA);
        TransferHelper.safeTransferFrom(tokenB, msg.sender, pair, amountB);
        liquidity = IBitlimeV2Pair(pair).mint(to);
    }
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external virtual override payable ensure(deadline) returns (uint amountToken, uint amountETH, uint liquidity) {
        (amountToken, amountETH) = _addLiquidity(
            token,
            WETH,
            amountTokenDesired,
            msg.value,
            amountTokenMin,
            amountETHMin
        );
        address pair = BitlimeV2Library.pairFor(factory, token, WETH);
        TransferHelper.safeTransferFrom(token, msg.sender, pair, amountToken);
        IWETH(WETH).deposit{value: amountETH}();
        assert(IWETH(WETH).transfer(pair, amountETH));
        liquidity = IBitlimeV2Pair(pair).mint(to);
        // refund dust eth, if any
        if (msg.value > amountETH) TransferHelper.safeTransferETH(msg.sender, msg.value - amountETH);
    }

    // **** REMOVE LIQUIDITY ****
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountA, uint amountB) {
        address pair = BitlimeV2Library.pairFor(factory, tokenA, tokenB);
        IBitlimeV2Pair(pair).transferFrom(msg.sender, pair, liquidity); // send liquidity to pair
        (uint amount0, uint amount1) = IBitlimeV2Pair(pair).burn(to);
        (address token0,) = BitlimeV2Library.sortTokens(tokenA, tokenB);
        (amountA, amountB) = tokenA == token0 ? (amount0, amount1) : (amount1, amount0);
        require(amountA >= amountAMin, 'BitlimeV2Router: INSUFFICIENT_A_AMOUNT');
        require(amountB >= amountBMin, 'BitlimeV2Router: INSUFFICIENT_B_AMOUNT');
    }
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountToken, uint amountETH) {
        (amountToken, amountETH) = removeLiquidity(
            token,
            WETH,
            liquidity,
            amountTokenMin,
            amountETHMin,
            address(this),
            deadline
        );
        TransferHelper.safeTransfer(token, to, amountToken);
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
    }
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountA, uint amountB) {
        address pair = BitlimeV2Library.pairFor(factory, tokenA, tokenB);
        uint value = approveMax ? uint(-1) : liquidity;
        IBitlimeV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        (amountA, amountB) = removeLiquidity(tokenA, tokenB, liquidity, amountAMin, amountBMin, to, deadline);
    }
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountToken, uint amountETH) {
        address pair = BitlimeV2Library.pairFor(factory, token, WETH);
        uint value = approveMax ? uint(-1) : liquidity;
        IBitlimeV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        (amountToken, amountETH) = removeLiquidityETH(token, liquidity, amountTokenMin, amountETHMin, to, deadline);
    }

    // **** REMOVE LIQUIDITY (supporting fee-on-transfer tokens) ****
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) public virtual override ensure(deadline) returns (uint amountETH) {
        (, amountETH) = removeLiquidity(
            token,
            WETH,
            liquidity,
            amountTokenMin,
            amountETHMin,
            address(this),
            deadline
        );
        TransferHelper.safeTransfer(token, to, IERC20(token).balanceOf(address(this)));
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
    }
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint amountETH) {
        address pair = BitlimeV2Library.pairFor(factory, token, WETH);
        uint value = approveMax ? uint(-1) : liquidity;
        IBitlimeV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        amountETH = removeLiquidityETHSupportingFeeOnTransferTokens(
            token, liquidity, amountTokenMin, amountETHMin, to, deadline
        );
    }

    // **** SWAP ****
    // requires the initial amount to have already been sent to the first pair
    function _swap(uint[] memory amounts, address[] memory path, address _to) internal virtual {
        for (uint i; i < path.length - 1; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0,) = BitlimeV2Library.sortTokens(input, output);
            uint amountOut = amounts[i + 1];
            (uint amount0Out, uint amount1Out) = input == token0 ? (uint(0), amountOut) : (amountOut, uint(0));
            address to = i < path.length - 2 ? BitlimeV2Library.pairFor(factory, output, path[i + 2]) : _to;
            IBitlimeV2Pair(BitlimeV2Library.pairFor(factory, input, output)).swap(
                amount0Out, amount1Out, to, new bytes(0)
            );
        }
    }
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress   //Address for our affiliate or white label
    ) external virtual override ensure(deadline) returns (uint[] memory amounts) {
        
        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, path[0]);
        
        //Decrease amountIn by the amount of the applicate commissions
        amountIn = amountIn - reward;
        

        amounts = BitlimeV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'BitlimeV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, BitlimeV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, to);
        amounts[0] = amountIn + reward; //reset correct amountIn for return
    }
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    ) external virtual override ensure(deadline) returns (uint[] memory amounts) {
        amounts = BitlimeV2Library.getAmountsIn(factory, amountOut, path);

        uint amountIn = amounts[0];
        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, path[0]);
        
        //Increase amountIn by the amount of the applicate commissions
        amountIn = amountIn + reward;
                

        require(amountIn <= amountInMax, 'BitlimeV2Router: EXCESSIVE_INPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, BitlimeV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, to);
    }
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        virtual
        override
        payable
        ensure(deadline)
        returns (uint[] memory amounts)
    {
        require(path[0] == WETH, 'BitlimeV2Router: INVALID_PATH');

        uint amountIn = msg.value;
        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, address(0));

        
        //Decrease amountIn by the amount of the applicate commissions
        amountIn = amountIn - reward;
        

        amounts = BitlimeV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'BitlimeV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(IWETH(WETH).transfer(BitlimeV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
        _swap(amounts, path, to);

        amounts[0] = amountIn + reward; //reset correct amountIn for return
    }
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        virtual
        override
        ensure(deadline)
        returns (uint[] memory amounts)
    {
        require(path[path.length - 1] == WETH, 'BitlimeV2Router: INVALID_PATH');
        amounts = BitlimeV2Library.getAmountsIn(factory, amountOut, path);

        uint amountIn = amounts[0];

        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, path[0]);
        
        //Increase amountIn by the amount of the applicate commissions
        amountIn = amountIn + reward;
                

        require(amountIn <= amountInMax, 'BitlimeV2Router: EXCESSIVE_INPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, BitlimeV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, address(this));
        IWETH(WETH).withdraw(amounts[amounts.length - 1]);
        TransferHelper.safeTransferETH(to, amounts[amounts.length - 1]);
    }
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        virtual
        override
        ensure(deadline)
        returns (uint[] memory amounts)
    {


        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, path[0]);
        
        //Decrease amountIn by the amount of the applicate commissions
        amountIn = amountIn - reward;
                


        require(path[path.length - 1] == WETH, 'BitlimeV2Router: INVALID_PATH');
        amounts = BitlimeV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'BitlimeV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, BitlimeV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, address(this));
        IWETH(WETH).withdraw(amounts[amounts.length - 1]);
        TransferHelper.safeTransferETH(to, amounts[amounts.length - 1]);

        amounts[0] = amountIn + reward; //reset correct amountIn for return
    }
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline, address affiliateAddress)
        external
        virtual
        override
        payable
        ensure(deadline)
        returns (uint[] memory amounts)
    {
        require(path[0] == WETH, 'BitlimeV2Router: INVALID_PATH');
        amounts = BitlimeV2Library.getAmountsIn(factory, amountOut, path);

        uint amountIn = amounts[0];
        
        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, address(0));
        
        //Increase amountIn by the amount of the applicate commissions
        amountIn = amountIn + reward;
        

        require(amountIn <= msg.value, 'BitlimeV2Router: EXCESSIVE_INPUT_AMOUNT');
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(IWETH(WETH).transfer(BitlimeV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
        _swap(amounts, path, to);
        // refund dust eth, if any
        if (msg.value > amountIn) TransferHelper.safeTransferETH(msg.sender, msg.value - amountIn);
    }

    // **** SWAP (supporting fee-on-transfer tokens) ****
    // requires the initial amount to have already been sent to the first pair
    function _swapSupportingFeeOnTransferTokens(address[] memory path, address _to) internal virtual {
        for (uint i; i < path.length - 1; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0,) = BitlimeV2Library.sortTokens(input, output);
            IBitlimeV2Pair pair = IBitlimeV2Pair(BitlimeV2Library.pairFor(factory, input, output));
            uint amountInput;
            uint amountOutput;
            { // scope to avoid stack too deep errors
            (uint reserve0, uint reserve1,) = pair.getReserves();
            (uint reserveInput, uint reserveOutput) = input == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
            amountInput = IERC20(input).balanceOf(address(pair)).sub(reserveInput);
            amountOutput = BitlimeV2Library.getAmountOut(amountInput, reserveInput, reserveOutput, factory);
            }
            (uint amount0Out, uint amount1Out) = input == token0 ? (uint(0), amountOutput) : (amountOutput, uint(0));
            address to = i < path.length - 2 ? BitlimeV2Library.pairFor(factory, output, path[i + 2]) : _to;
            pair.swap(amount0Out, amount1Out, to, new bytes(0));
        }
    }
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    ) external virtual override ensure(deadline) {

        
        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, path[0]);
        
        //Decrease amountIn by the amount of the applicate commissions
        amountIn = amountIn - reward;
                

        TransferHelper.safeTransferFrom(
            path[0], msg.sender, BitlimeV2Library.pairFor(factory, path[0], path[1]), amountIn
        );
        uint balanceBefore = IERC20(path[path.length - 1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        require(
            IERC20(path[path.length - 1]).balanceOf(to).sub(balanceBefore) >= amountOutMin,
            'BitlimeV2Router: INSUFFICIENT_OUTPUT_AMOUNT'
        );
    }
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    )
        external
        virtual
        override
        payable
        ensure(deadline)
    {
        require(path[0] == WETH, 'BitlimeV2Router: INVALID_PATH');

        uint amountIn = msg.value;
        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, address(0));
        
        //Decrease amountIn by the amount of the applicate commissions
        amountIn = amountIn - reward;
                


        IWETH(WETH).deposit{value: amountIn}();
        assert(IWETH(WETH).transfer(BitlimeV2Library.pairFor(factory, path[0], path[1]), amountIn));
        uint balanceBefore = IERC20(path[path.length - 1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        require(
            IERC20(path[path.length - 1]).balanceOf(to).sub(balanceBefore) >= amountOutMin,
            'BitlimeV2Router: INSUFFICIENT_OUTPUT_AMOUNT'
        );
    }
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline,
        address affiliateAddress
    )
        external
        virtual
        override
        ensure(deadline)
    {


        uint reward = _affiliateAndWhiteLabel(affiliateAddress, amountIn, path[0]);
        
        //Decrease amountIn by the amount of the applicate commissions
        amountIn = amountIn - reward;
                


        require(path[path.length - 1] == WETH, 'BitlimeV2Router: INVALID_PATH');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, BitlimeV2Library.pairFor(factory, path[0], path[1]), amountIn
        );
        _swapSupportingFeeOnTransferTokens(path, address(this));
        uint amountOut = IERC20(WETH).balanceOf(address(this));
        require(amountOut >= amountOutMin, 'BitlimeV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        IWETH(WETH).withdraw(amountOut);
        TransferHelper.safeTransferETH(to, amountOut);
    }


    function _setAffiliate(address affiliateAddress) internal virtual {
        //Check if the user not exist
        if( userExists[msg.sender] == address(0) ) {
            //if the user not exist, check if AffiliateAddress not exist
            if( affiliateAddress == address(0) || affiliateAddress == msg.sender ) {
                //Locate the user under the Affiliate Address of the FeeTo (Replace msg.sender with FeeTo)
                address AdminAddress = IBitlimeV2Factory(factory).feeTo();
                userExists[msg.sender] = AdminAddress;
                AffiliateList[AdminAddress].push(msg.sender);
            } else {
                //if the AffiliateAddress exist, set the user under the AffiliateAddress
                userExists[msg.sender] = affiliateAddress;
                AffiliateList[affiliateAddress].push(msg.sender);
            }
        }
    }


    function _affiliateAndWhiteLabel(address affiliateAddress, uint amountIn, address TokenAddress) internal virtual returns (uint reward) {
        //If is an Affiliate
        if ( whiteLabelCommission[affiliateAddress] == 0 ) {
            //function to set the affiliate for this user
            _setAffiliate(affiliateAddress);
            
            //Calculate Affiliate reward
            reward = amountIn.mul(affiliateCommission) / 10000;
            //Send reward to the Affiliate (if TokenAddress is 0, send eth)
            if ( TokenAddress == address(0)){
	            address payable toAffiliate = payable(userExists[msg.sender]);
                toAffiliate.transfer(reward);
            } else {
                TransferHelper.safeTransferFrom(TokenAddress, msg.sender, userExists[msg.sender], reward);
            }
        } else {
            //if is white label, Send reward to the WhiteLabel
            //Calculate WhiteLabel owner reward
            reward = amountIn.mul(whiteLabelCommission[affiliateAddress]) / 10000;
            //Send reward to the WhiteLabel owner (if TokenAddress is 0, send eth)
            if ( TokenAddress == address(0)){
	            address payable toWhiteLabel = payable(affiliateAddress);
                toWhiteLabel.transfer(reward);
            } else {
                TransferHelper.safeTransferFrom(TokenAddress, msg.sender, affiliateAddress, reward);
            }
        }
    }


    function _quoteReward(address affiliateAddress, uint amountIn) internal view virtual returns (uint reward) {
        //If is an Affiliate
        if ( whiteLabelCommission[affiliateAddress] == 0 ) {            
            //Calculate Affiliate reward
            reward = amountIn.mul(affiliateCommission) / 10000;
        } else {
            //if is white label, Send reward to the WhiteLabel
            //Calculate WhiteLabel owner reward
            reward = amountIn.mul(whiteLabelCommission[affiliateAddress]) / 10000;
        }
    }


    // **** LIBRARY FUNCTIONS ****
    function quote(uint amountA, uint reserveA, uint reserveB) public pure virtual override returns (uint amountB) {
        return BitlimeV2Library.quote(amountA, reserveA, reserveB);
    }

    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut, address affiliateAddress)
        public
        view
        virtual
        override
        returns (uint amountOut)
    {
        uint reward = _quoteReward(affiliateAddress, amountIn);
        amountIn = amountIn - reward;
        return BitlimeV2Library.getAmountOut(amountIn, reserveIn, reserveOut, factory);
    }

    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut, address affiliateAddress)
        public
        view
        virtual
        override
        returns (uint amountIn)
    {
        amountIn = BitlimeV2Library.getAmountIn(amountOut, reserveIn, reserveOut, factory);
        uint reward = _quoteReward(affiliateAddress, amountIn);
        amountIn = amountIn + reward;
        return amountIn;
    }

    function getAmountsOut(uint amountIn, address[] memory path, address affiliateAddress)
        public
        view
        virtual
        override
        returns (uint[] memory amounts)
    {
        uint reward = _quoteReward(affiliateAddress, amountIn);
        amountIn = amountIn - reward;
        amounts = BitlimeV2Library.getAmountsOut(factory, amountIn, path);
        amounts[0] = amountIn + reward; //reset correct amountIn for return
    }

    function getAmountsIn(uint amountOut, address[] memory path, address affiliateAddress)
        public
        view
        virtual
        override
        returns (uint[] memory amounts)
    {
        amounts = BitlimeV2Library.getAmountsIn(factory, amountOut, path);
        uint amountIn = amounts[0];
        uint reward = _quoteReward(affiliateAddress, amountIn);
        amountIn = amountIn + reward;
        amounts[0] = amountIn;
    }
}
