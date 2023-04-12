from setuptools import setup, find_packages

setup(
    name="fsoft_diff_patch",
    version="0.1.0",
    description="Deep compare two objects and produces a diffData to transform object1 to object2",
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
