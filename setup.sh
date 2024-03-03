#!/bin/bash

venv_name="iac_dev"
alias_name="iac_dev"

# Check if the virtual environment is already set
if [[ -d "$HOME/$venv_name" ]]; then
    echo "Virtual environment $venv_name already exists."
    echo "Do you want to update it? [y/n]"

    read response
    if [[ "$response" != "y" ]]; then
        echo "Exiting venv setup"
        exit 1
    fi
fi

# Create the virtual environment
echo "Creating virtual environment $venv_name..."
python3 -m venv $HOME/$venv_name

echo "alias $alias_name='source $HOME/$venv_name/bin/activate'" >> $HOME/.bash_aliases
source $HOME/.bashrc

source $HOME/$venv_name/bin/activate

echo "Installing packages from requirements.txt..."
pip install -r requirements.txt

