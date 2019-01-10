import Header from "./Header";
import React from "react";

import StudentApplications from "./Student/ApplicationPresenter";
import StudentHelp from "./Student/StudentHelp"
import ApplicationManager from "./Student/ApplicationManager";

import PublisherPublish from "./Publisher/PublisherPublish";
import PublisherHelp from "./Publisher/PublisherHelp";

import SecretaryHelp from "./Secretary/SecretaryHelp";

import DistributorHelp from "./Distributor/DistributorHelp";

import { NotFoundSmall } from "./NotFound";


export default {
    Student: {
        Header: "Φοιτητές",
        Actions: [
            "Δήλωση Συγγραμμάτων",
            "Προβολή Δηλώσεων",
            "Οδηγίες - Βοήθεια"
        ],
        Quicks: [0, 1, 2],
        Default: 2,
        Components: [
            (props) => {return <ApplicationManager id={props.id}/>},
            () => {return <StudentApplications/>},
            () => {return <StudentHelp/>},
        ],
        Type: "Student"
    },
    Secretary: {
        Header: "Γραμματείες",
        Actions: [
            "Καταχώριση Μαθημάτων",
            "Αντιστοίχιση Συγραμμάτων",
            "Προβολή Καταχωρημένων Μαθημάτων",
            "Οδηγίες - Βοήθεια"
        ],
        Quicks: [0, 1, 3],
        Default: 3,
        Components: [
            () => {return <NotFoundSmall/>},
            () => {return <NotFoundSmall/>},
            () => {return <NotFoundSmall/>},
            () => {return <SecretaryHelp/>},
        ],
        Type: "Secretary"
    },
    Publisher: {
        Header: "Εκδότες",
        Actions: [
            "Καταχώριση Συγγραμμάτων",
            "Επιλογή Σημείων Διανομής",
            "Προβολή Περασμένων Συγραμμάτων",
            "Προβολή Αιτήσεων",
            "Οδηγίες - Βοήθεια"
        ],
        Quicks: [0, 2, 4],
        Default: 4,
        Components: [
            () => {return <PublisherPublish/>},
            () => {return <NotFoundSmall/>},
            () => {return <NotFoundSmall/>},
            () => {return <NotFoundSmall/>},
            () => {return <PublisherHelp/>},
        ],
        Type: "Publisher"
    },
    Distributor: {
        Header: "Διανομείς",
        Actions: [
            "Παράδοση Συγγραμμάτων",
            "Προβολή Συγγραμμάτων",
            "Προβολή Αιτήσεων",
            "Οδηγίες - Βοήθεια"
        ],
        Quicks: [0, 1, 3],
        Default: 3,
        Components: [
            () => {return <NotFoundSmall/>},
            () => {return <NotFoundSmall/>},
            () => {return <NotFoundSmall/>},
            () => {return <DistributorHelp/>},
        ],
        Type: "Distributor"
    },
    Search: {
        Header: "Αναζήτηση",
        Actions: [
            "Συγγράμματα",
            "Εκδότες",
            "Σημεία Διανομής"
        ]
    }
}