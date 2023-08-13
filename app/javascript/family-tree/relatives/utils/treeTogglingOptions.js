const dataset = () => {
  return document.getElementById('family-tree').dataset
}

export const isNotDegradedMode = () => {
  return !(dataset.degradedMode === 'on');
};

export const switchDegradedMode = (option) => {
  dataset.degradedMode = option;
  console.log('Degraded mode activated');
};

export const isShowingGender = () => {
  return (dataset.showGender === 'on');
};

export const switchShowGender = (option) => {
  dataset.showGender = option;
  console.log('Show Gender activated');
};

export const isShowingDeceased = () => {
  return (dataset.showDeceased === 'on');
};

export const switchShowDeceased = (option) => {
  dataset.showDeceased = option;
  console.log('Degraded mode activated');
};
//# sourceMappingURL=createChildUnitsFunc.js.map
