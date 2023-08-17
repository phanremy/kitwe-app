export const isNotDegradedMode = () => {
  return !(document.getElementById('tree').dataset.degradedMode === 'on');
};

export const switchDegradedMode = (option) => {
  document.getElementById('tree').dataset.degradedMode = option;
  console.log(`Degraded mode ${option}`);
};

export const isShowingGender = () => {
  return (document.getElementById('tree').dataset.showGender === 'on');
};

export const isShowingDeceased = () => {
  return (document.getElementById('tree').dataset.showDeceased === 'on');
};

export const isShowingCoupleStatus = () => {
  return (document.getElementById('tree').dataset.showCoupleStatus === 'on');
};
//# sourceMappingURL=createChildUnitsFunc.js.map
