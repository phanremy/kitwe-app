import { relToNode } from 'family-tree/relatives/utils/methods';
const createRel = (id, type = "blood") => ({ id, type });
const createNode = (gender) => ({
    id: `${gender}-ph`,
    placeholder: true,
    gender: gender,
    parents: [],
    siblings: [],
    spouses: [],
    children: [],
});
const createParents = (store) => {
    const father = createNode("male");
    const mother = createNode("female");
    father.spouses = [createRel(mother.id, "married")];
    mother.spouses = [createRel(father.id, "married")];
    return [father, mother].map(node => {
        node.children = store.root.siblings.concat(createRel(store.root.id));
        store.nodes.set(node.id, node);
        return createRel(node.id);
    });
};
const setParents = (parents) => ((node) => node.parents = parents.slice());
export const placeholders = (store) => {
    if (!store.root.parents.length) {
        const setParentsTo = setParents(createParents(store));
        setParentsTo(store.root);
        store.root.siblings
            .map(relToNode(store))
            .forEach(setParentsTo);
    }
    return store;
};
//# sourceMappingURL=placeholders.js.map
