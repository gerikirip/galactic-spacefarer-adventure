using { cuid } from '@sap/cds/common';

entity Spacefarers : cuid {
    @Core.Immutable
    @mandatory
    @title: 'Name'
    name: String not null;

    @assert.unique
    @Core.Immutable
    @mandatory
    @title: 'User Name'
    userName: String not null;

    stardustCollection: Integer;

    @Core.Immutable
    @mandatory
    @title: 'Wormhole Navigation Skill'
    wormholeNavigationSkill: Integer;

    @Core.Immutable
    @mandatory
    @title: 'Origin Planet'
    originPlanet: String not null;

    spaceSuitColor: SpaceSuitColor;

    @Core.Immutable
    @mandatory
    @title: 'Department'
    department: Association to Departments;

    @Core.Immutable
    @mandatory
    @title: 'Position'
    position: Association to Positions;
}

type SpaceSuitColor : String enum {
    Red; Blue; Green; Yellow; White; Black;
}

entity Departments : cuid {
    @assert.unique
    name: String;
}

entity Positions : cuid {
    @assert.unique
    name: String;
}