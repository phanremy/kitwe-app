export const nextIndex = (index) => index + 1;
export const prop = (name) => (item) => item[name];
export const withId = (id) => (item) => item.id === id;
export const withIds = (ids, include = true) => ((item) => ids.includes(item.id) === include);
export const unique = (item, index, arr) => arr.indexOf(item) === index;
export const inAscOrder = (v1, v2) => v1 - v2;
export const pipe = (...fus) => (init) => fus.reduce((res, fn) => fn(res), init);
export const min = (arr) => Math.min.apply(null, arr);
export const max = (arr) => Math.max.apply(null, arr);
export const toMap = (items) => (new Map(items.map((item) => [item.id, { ...item }])));
export const hasDiffParents = (node) => node.parents.map(prop('type')).filter(unique).length > 1;
// export const byGender = (target) => (a, b) => (b.gender !== target) ? -1 : 0;
export const byGender = (target) => (a, b) => (a.gender == 'female') ? 0 : -1;
export const relToNode = (store) => (rel) => store.getNode(rel.id);
export const withRelType = (...types) => (item) => types.includes(item.type);
//# sourceMappingURL=index.js.map
