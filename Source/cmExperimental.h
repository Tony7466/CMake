/* Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
   file Copyright.txt or https://cmake.org/licensing for details.  */

#pragma once

#include "cmConfigure.h" // IWYU pragma: keep

class cmMakefile;

class cmExperimental
{
public:
  enum class Feature
  {
    Sentinel,
  };

  static bool HasSupportEnabled(cmMakefile const& mf, Feature f);
};
