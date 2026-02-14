"""Compatibility shim: expose ssdp discovery at top-level

Some code expects to import `mindaffectBCI.ssdpDiscover`. The real
implementation lives in `mindaffectBCI.utopia.ssdpDiscover`. Re-export
the commonly used names here for backward compatibility.
"""
from .utopia.ssdpDiscover import ssdpDiscover, discoverOrIPscan, ipscanDiscover  # noqa: F401

__all__ = ["ssdpDiscover", "discoverOrIPscan", "ipscanDiscover"]
