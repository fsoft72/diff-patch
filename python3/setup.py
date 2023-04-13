from setuptools import setup, find_packages
import pathlib

# Leggi il contenuto del file README.md
long_description = (pathlib.Path(__file__).parent / "README.md").read_text(
    encoding="utf-8"
)

setup(
    name="fsoft_diff_patch",
    version="0.1.1",
    description="Deep compare two objects and produces a diffData to transform object1 to object2",
    long_description=long_description,
    long_description_content_type="text/markdown",
    author="Fabio Rotondo",
    author_email="fabio.rotondo@gmail.com",
    packages=find_packages(),
    install_requires=[
        # Aggiungi qui eventuali dipendenze
    ],
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3",
    ],
)
