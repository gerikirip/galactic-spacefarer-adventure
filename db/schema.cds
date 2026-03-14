using { cuid } from '@sap/cds/common';

entity Spacefarers : cuid {
    name: String not null;
    @assert.unique
    userName: String not null;
    stardustCollection: Integer;
    wormholeNavigationSkill: Integer;
    originPlanet: String not null;
    spaceSuitColor : SpaceSuitColor;
    department : Association to Departments;
    position   : Association to Positions;
}

type SpaceSuitColor : String enum {
    Red; Blue; Green; Yellow; White; Black;
}

entity Departments : cuid {
    @assert.unique
    name : String;
}

entity Positions : cuid {
    @assert.unique
    name : String;
}