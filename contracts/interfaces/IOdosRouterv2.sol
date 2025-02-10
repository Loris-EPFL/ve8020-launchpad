// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface IOdosRouterV2 {
    struct inputTokenInfo {
        address tokenAddress;
        uint256 amountIn;
        address receiver;
    }

    struct outputTokenInfo {
        address tokenAddress;
        uint256 relativeValue;
        address receiver;
    }

    struct permit2Info {
        address contractAddress;
        uint256 nonce;
        uint256 deadline;
        bytes signature;
    }

    struct swapTokenInfo {
        address inputToken;
        uint256 inputAmount;
        address inputReceiver;
        address outputToken;
        uint256 outputQuote;
        uint256 outputMin;
        address outputReceiver;
    }

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Swap(
        address sender,
        uint256 inputAmount,
        address inputToken,
        uint256 amountOut,
        address outputToken,
        int256 slippage,
        uint32 referralCode
    );
    event SwapMulti(
        address sender,
        uint256[] amountsIn,
        address[] tokensIn,
        uint256[] amountsOut,
        address[] tokensOut,
        uint32 referralCode
    );

    receive() external payable;

    function FEE_DENOM() external view returns (uint256);
    function REFERRAL_WITH_FEE_THRESHOLD() external view returns (uint256);
    function addressList(uint256) external view returns (address);
    function owner() external view returns (address);
    function referralLookup(uint32) external view returns (uint64 referralFee, address beneficiary, bool registered);
    function registerReferralCode(uint32 _referralCode, uint64 _referralFee, address _beneficiary) external;
    function renounceOwnership() external;
    function setSwapMultiFee(uint256 _swapMultiFee) external;
    function swap(swapTokenInfo memory tokenInfo, bytes memory pathDefinition, address executor, uint32 referralCode)
        external
        payable
        returns (uint256 amountOut);
    function swapCompact() external payable returns (uint256);
    function swapMulti(
        inputTokenInfo[] memory inputs,
        outputTokenInfo[] memory outputs,
        uint256 valueOutMin,
        bytes memory pathDefinition,
        address executor,
        uint32 referralCode
    ) external payable returns (uint256[] memory amountsOut);
    function swapMultiCompact() external payable returns (uint256[] memory amountsOut);
    function swapMultiFee() external view returns (uint256);
    function swapMultiPermit2(
        permit2Info memory permit2,
        inputTokenInfo[] memory inputs,
        outputTokenInfo[] memory outputs,
        uint256 valueOutMin,
        bytes memory pathDefinition,
        address executor,
        uint32 referralCode
    ) external payable returns (uint256[] memory amountsOut);
    function swapPermit2(
        permit2Info memory permit2,
        swapTokenInfo memory tokenInfo,
        bytes memory pathDefinition,
        address executor,
        uint32 referralCode
    ) external returns (uint256 amountOut);
    function swapRouterFunds(
        inputTokenInfo[] memory inputs,
        outputTokenInfo[] memory outputs,
        uint256 valueOutMin,
        bytes memory pathDefinition,
        address executor
    ) external returns (uint256[] memory amountsOut);
    function transferOwnership(address newOwner) external;
    function transferRouterFunds(address[] memory tokens, uint256[] memory amounts, address dest) external;
    function writeAddressList(address[] memory addresses) external;
}
