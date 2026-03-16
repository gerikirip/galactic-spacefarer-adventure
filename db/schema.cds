using { cuid } from '@sap/cds/common';

entity Spacefarers : cuid {
    @Core.Immutable 
    @title: 'Name'
    name: String not null;

    @assert.unique
    @Core.Immutable 
    @title: 'User Name'
    userName: String not null;

    stardustCollection: Integer;

    wormholeNavigationSkill: Integer;

    @Core.Immutable 
    @title: 'Origin Planet'
    originPlanet: String not null;

    spaceSuitColor: SpaceSuitColor;

    @Core.Immutable 
    @title: 'Department'
    department: Association to Departments;

    @Core.Immutable 
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