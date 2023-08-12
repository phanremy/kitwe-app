export const isNotDegradedMode = () => {
  return !document.getElementById('degraded-mode').checked;
};

export const switchToDegratedMode = () => {
  document.getElementById('degraded-mode').checked = true;
  console.log('Degraded mode activated');
};
//# sourceMappingURL=createChildUnitsFunc.js.map
