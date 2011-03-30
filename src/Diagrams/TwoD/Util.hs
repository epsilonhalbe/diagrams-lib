{-# LANGUAGE FlexibleContexts
  #-}
-----------------------------------------------------------------------------
-- |
-- Module      :  Diagrams.TwoD.Util
-- Copyright   :  (c) 2011 diagrams-lib team (see LICENSE)
-- License     :  BSD-style (see LICENSE)
-- Maintainer  :  diagrams-discuss@googlegroups.com
--
-- Utility functions for diagrams in two-dimensional Cartesian space.
--
-----------------------------------------------------------------------------
module Diagrams.TwoD.Util
       ( width, height, size2D
       , extentX, extentY, center2D
       ) where

import Graphics.Rendering.Diagrams
import Diagrams.TwoD.Types

import Control.Arrow ((***), (&&&))

-- | Compute the width of a diagram in R2.
width :: Backend b R2 => AnnDiagram b R2 m -> Double
width = negate . uncurry (-) . extentX

-- | Compute the height of a diagram in R2.
height :: Backend b R2 => AnnDiagram b R2 m -> Double
height = negate . uncurry (-) . extentY

-- | Compute the width and height of a diagram in R2.
size2D :: Backend b R2 => AnnDiagram b R2 m -> (Double, Double)
size2D = width &&& height

-- | Compute the absolute x-coordinate range of a diagram in R2, in
--   the form (lo,hi).
extentX :: Backend b R2 => AnnDiagram b R2 a -> (Double, Double)
extentX d = (-f (-1,0), f (1,0))
  where f = getBoundFunc $ bounds d

-- | Compute the absolute y-coordinate range of a diagram in R2, in
--   the form (lo,hi).
extentY :: Backend b R2 => AnnDiagram b R2 a -> (Double, Double)
extentY d = (-f (0,-1), f (0,1))
  where f = getBoundFunc $ bounds d

-- | Compute the center of a diagram in R2.
center2D :: Backend b R2 => AnnDiagram b R2 a -> P2
center2D = P . (mid *** mid) . (extentX &&& extentY)
  where mid = (/2) . uncurry (+)


-- XXX add X and Y unit vectors