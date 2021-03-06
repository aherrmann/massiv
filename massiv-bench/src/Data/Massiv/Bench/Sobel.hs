{-# LANGUAGE BangPatterns #-}
module Data.Massiv.Bench.Sobel
  ( sobelX
  , sobelY
  , sobelOperator
  ) where

import Data.Massiv.Array

sobelX :: Num e => Stencil Ix2 e e
sobelX =
  makeConvolutionStencil (Sz 3) (1 :. 1) $
  \ f -> f (-1 :. -1) (-1) .
         f ( 0 :. -1) (-2) .
         f ( 1 :. -1) (-1) .
         f (-1 :.  1)   1  .
         f ( 0 :.  1)   2  .
         f ( 1 :.  1)   1
{-# INLINE sobelX #-}


sobelY :: Num e => Stencil Ix2 e e
sobelY =
  makeConvolutionStencil (Sz 3) (1 :. 1) $
  \ f -> f (-1 :. -1) (-1) .
         f (-1 :.  0) (-2) .
         f (-1 :.  1) (-1) .
         f ( 1 :. -1)   1  .
         f ( 1 :.  0)   2  .
         f ( 1 :.  1)   1
{-# INLINE sobelY #-}


sobelOperator :: Floating b => Stencil Ix2 b b
sobelOperator = sqrt (sX + sY)
  where
    !sX = fmap (^ (2 :: Int)) sobelX
    !sY = fmap (^ (2 :: Int)) sobelY
{-# INLINE sobelOperator #-}
