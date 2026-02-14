"""Lightweight FakeUtopia controller used for offline presentation/testing.

The class implements the small subset of the UtopiaController API used by
`selectionMatrix.py` and `noisetag` so the presentation can run without a
real hub.
"""
from __future__ import annotations

from typing import Any, Callable, List, Optional, Tuple


class FakeUtopia:
    def __init__(self) -> None:
        self.msgs: List[Any] = []
        self._last_prediction: Optional[Any] = None
        self._last_selection: Tuple[Optional[Any], bool] = (None, False)
        self._last_signal_quality: Optional[Any] = None
        self._sel_handlers: List[Callable[[Any], None]] = []
        self._msg_handlers: List[Callable[[Any], None]] = []
        self._pred_handlers: List[Callable[[Any], None]] = []

    def isConnected(self) -> bool:
        return False

    def getTimeStamp(self) -> int:
        import time

        return int(time.perf_counter() * 1000) % (1 << 31)

    def getLastPrediction(self) -> Optional[Any]:
        return self._last_prediction

    def clearLastPrediction(self) -> None:
        self._last_prediction = None

    def getLastSelection(self) -> Tuple[Optional[Any], bool]:
        return self._last_selection

    def clearLastSelection(self) -> None:
        self._last_selection = (None, False)

    def newTarget(self) -> None:
        return

    def selection(self, objId: Any) -> None:
        self._last_selection = (objId, True)
        for cb in list(self._sel_handlers):
            try:
                cb(objId)
            except Exception:
                pass

    def getNewMessages(self) -> List[Any]:
        return list(self.msgs)

    def subscribe(self, msgs: List[Any]) -> None:
        return

    def addSelectionHandler(self, cb: Callable[[Any], None]) -> None:
        self._sel_handlers.append(cb)

    def addMessageHandler(self, cb: Callable[[Any], None]) -> None:
        self._msg_handlers.append(cb)

    def addPredictionHandler(self, cb: Callable[[Any], None]) -> None:
        self._pred_handlers.append(cb)

    def removeSubscription(self, msgs: List[Any]) -> None:
        return

    def addSubscription(self, msgs: List[Any]) -> None:
        return

    def modeChange(self, mode: Any) -> None:
        return

    def sendStimulusEvent(self, *args: Any, **kwargs: Any) -> None:
        return

    def log(self, msg: str) -> None:
        return

    def setTimeStampClock(self, ts: Any) -> None:
        return

    def gethostport(self) -> str:
        return "none"

    def getLastSignalQuality(self) -> Optional[Any]:
        return self._last_signal_quality

    def clearLastSignalQuality(self) -> None:
        self._last_signal_quality = None
