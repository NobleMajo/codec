#!/bin/bash

targetPath=$1

echo "Delete package manager dependencies in '$targetPath'..."
directories=$(find $targetPath -type d)

# Gehe durch die Liste der Verzeichnisse und lösche alle Ordner, die den exakten Namen "node_modules", "packages" oder "include/lib" haben.
for directory in $directories; do
  # NPM
  if [[ "$directory" == "node_modules" ]]; then
    if [[ -f "$directory/../package.json" ]]; then
      echo "Deleting node_modules '$directory'..."
      rm -rf $directory
    else
      echo "Skipping node_modules '$directory' because no package.json file was found."
    fi
  fi

  # DOTNET/C#
  if [[ "$directory" == "packages" ]]; then
    if [[ -f "$directory/../packages.config" ]]; then
      echo "Deleting packages '$directory'..."
      rm -rf $directory
    else
      echo "Skipping packages '$directory' because no packages.config file was found."
    fi
  fi

  # C++
  if [[ "$directory" == "include" || "$directory" == "lib" ]]; then
    if [[ -f "$directory/../CMakeLists.txt" ]]; then
      echo "Deleting include/lib '$directory'..."
      rm -rf $directory
    else
      echo "Skipping include/lib '$directory' because no CMakeLists.txt file was found."
    fi
  fi
done

echo "Done!"
