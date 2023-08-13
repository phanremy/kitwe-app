export const isNotDegradedMode = () => {
  return !(document.getElementById('family-tree').dataset.degradedMode === 'on');
};

export const switchDegradedMode = (option) => {
  document.getElementById('family-tree').dataset.degradedMode = option;
  console.log(`Degraded mode ${option}`);
};

export const isShowingGender = () => {
  return (document.getElementById('family-tree').dataset.showGender === 'on');
};

export const isShowingDeceased = () => {
  return (document.getElementById('family-tree').dataset.showDeceased === 'on');
};
//# sourceMappingURL=createChildUnitsFunc.js.map
