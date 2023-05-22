// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;
pragma abicoder v2;

import './MockTimeUniswapV3Pair.sol';
import '../interfaces/IUniswapV3PairDeployer.sol';

contract MockTimeUniswapV3PairDeployer is IUniswapV3PairDeployer {
    struct Parameters {
        address factory;
        address token0;
        address token1;
        uint24 fee;
        int24 tickSpacing;
    }

    Parameters public override parameters;

    event PairCreated(address pair);

    function deploy(
        address factory,
        address token0,
        address token1,
        uint24 fee,
        int24 tickSpacing
    ) external returns (address pair) {
        parameters = Parameters({factory: factory, token0: token0, token1: token1, fee: fee, tickSpacing: tickSpacing});
        pair = address(
            new MockTimeUniswapV3Pair{salt: keccak256(abi.encodePacked(token0, token1, fee, tickSpacing))}()
        );
        emit PairCreated(pair);
        delete parameters;
    }
}
