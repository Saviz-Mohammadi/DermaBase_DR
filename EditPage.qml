import QtCore
import QtQuick
import QtQuick.Controls.impl
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Dialogs

// Custom CPP:
import ProxyFilter 1.0
import DiagnosesListModel 1.0
import PatientDiagnosesModel 1.0
import TreatmentsListModel 1.0
import PatientTreatmentsModel 1.0
import ProceduresListModel 1.0
import PatientProceduresModel 1.0
import ConsultantsListModel 1.0
import PatientConsultationsModel 1.0
import LabsListModel 1.0
import PatientLabTestsModel 1.0
import PatientImagesModel 1.0

Item {
    id: root

    signal startedLoadingPatientForEditing();
    signal finishedLoadingPatientForEditing(isSuccessful: bool);

    property int topMargin: 15
    property int bottomMargin: 15
    property int rightMargin: 15
    property int leftMargin: 15
    property int spacing: 10
    property real titleFontSizeScalar: 2

    function loadPatient(patientID: int) {
        root.startedLoadingPatientForEditing();

        mainDatabase.getPatientBasicInformation(patientID);
        mainDatabase.getPatientVisitInformation(patientID);
        mainDatabase.getPatientPaymentInformation(patientID);
        mainDatabase.getDiagnosesList();
        mainDatabase.getPatientDiagnoses(patientID);
        mainDatabase.getPatientDiagnosesNote(patientID);
        mainDatabase.getTreatmentsList();
        mainDatabase.getPatientTreatments(patientID);
        mainDatabase.getPatientTreatmentsNote(patientID);
        mainDatabase.getProceduresList();
        mainDatabase.getPatientProcedures(patientID);
        mainDatabase.getPatientProceduresNote(patientID);
        mainDatabase.getConsultantsList();
        mainDatabase.getPatientConsultations(patientID);
        mainDatabase.getPatientImages(patientID);
        mainDatabase.getLabsList();
        mainDatabase.getPatientLabTests(patientID);
        mainDatabase.getPatientDeletionStatus(patientID);

        qtObjectEditInformation.patientID = patientID;
    }

    function performEvaluation() {
        let totalCallsRequired = 18;
        let totalSuccessesRequired = 18;

        if(qtObjectEditInformation.countOfCallsCompleted !== totalCallsRequired) {
            return;
        }

        // If all calls are successful:
        if(qtObjectEditInformation.countOfCallsSucceeded === totalSuccessesRequired) {
            root.resetCounters();

            root.finishedLoadingPatientForEditing(true);

            return;
        }

        // Reset:
        root.resetCounters();

        root.finishedLoadingPatientForEditing(false);
    }

    function resetCounters() {
        qtObjectEditInformation.countOfCallsCompleted = 0;
        qtObjectEditInformation.countOfCallsSucceeded = 0;
    }

    QtObject {
        id: qtObjectEditInformation

        property int countOfCallsCompleted: 0
        property int countOfCallsSucceeded: 0
        property int patientID: -1
    }

    // NOTE (SAVIZ): In my opinnion, when it comes to loading the data we don't really need to notify the start of every retrieval since that would be insane. I think the best approach is to only notify the user if something went wrong that requires us to note about.
    Connections {
        target: mainDatabase

        // NOTE (SAVIZ): We do not require any additional parameters for checking the outcome:
        function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientVisitInformation(status: int, message: string, numberOfPreviousVisits: int, firstVisitDate: string, recentVisitDate: string, expectedVisitDate: string) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientPaymentInformation(status: int, message: string, servicePrice: real, paidPrice: real) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        // Here
        function onFinishedGettingDiagnosesList(status: int, message: string, data) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientDiagnoses(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1 || status === -1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientDiagnosesNote(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingTreatmentsList(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientTreatments(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1 || status === -1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientTreatmentsNote(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingProceduresList(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientProcedures(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1 || status === -1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientProceduresNote(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingConsultantsList(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientConsultations(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1 || status === -1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientImages(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1 || status === -1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingLabsList(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientLabTests(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1 || status === -1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }

        function onFinishedGettingPatientDeletionStatus(status: int) {
            qtObjectEditInformation.countOfCallsCompleted += 1;

            if(status === 1) {
                qtObjectEditInformation.countOfCallsSucceeded += 1;
            }

            root.performEvaluation();
        }
    }

    ScrollView {
        id: scrollView

        anchors.fill: parent

        contentWidth: -1
        contentHeight: columnLayout.implicitHeight + root.topMargin + root.bottomMargin
        ScrollBar.horizontal.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        background: Rectangle {
            id: rectangleBackground

            radius: 0
            color: AppTheme.getColor(AppTheme.Colors.PageBackground)
        }

        Item {
            anchors.fill: parent
            anchors.topMargin: root.topMargin
            anchors.bottomMargin: root.bottomMargin
            anchors.rightMargin: root.rightMargin
            anchors.leftMargin: root.leftMargin

            ColumnLayout {
                id: columnLayout

                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left

                clip: false
                spacing: root.spacing

                RowLayout {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 40

                    spacing: 10

                    IconLabel {
                        Layout.preferredHeight: 40

                        icon.width: 32
                        icon.height: 32
                        icon.source: "qrc:/resources/icons/material/person_edit.svg"
                        icon.color: AppTheme.getColor(AppTheme.Colors.PageIcon)
                    }

                    Text {
                        Layout.preferredHeight: 40

                        color: AppTheme.getColor(AppTheme.Colors.PageText)
                        elide: Text.ElideRight
                        font.pixelSize: Qt.application.font.pixelSize * root.titleFontSizeScalar
                        text: qsTr("ویرایش بیمار")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignTop
                        wrapMode: Text.NoWrap
                    }
                }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.bottomMargin: 40

                    Text {
                        id: textPatientTitle

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        font.pixelSize: Qt.application.font.pixelSize * 1.3
                        text: qsTr("هیچ بیماری انتخاب نشده است")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    UFOButton {
                        id: buttonDeletePatient

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35

                        checkable: true
                        display: AbstractButton.TextBesideIcon
                        enabled: false
                        text: qsTr("حذف بیمار")
                        icon.source: "qrc:/resources/icons/material/person_remove.svg"

                        onCheckedChanged: {
                            mainDatabase.updatePatientDeletionStatus(qtObjectEditInformation.patientID, buttonDeletePatient.checked);
                        }

                        Connections {
                            target: root

                            function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                                if(isSuccessful === true) {

                                    buttonDeletePatient.enabled = true;
                                }
                            }
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientDeletionStatus(status: int, message: string, deletionStatus: bool) {
                                if(status === 1) {

                                    buttonDeletePatient.checked = deletionStatus;
                                }
                            }
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedUpdatingPatientDeletionStatus(status: int, message: string) {
                                if(status === 1) {

                                    buttonDeletePatient.checked = true;
                                    return;
                                }

                                buttonDeletePatient.checked = false;
                            }
                        }
                    }

                    Connections {
                        target: mainDatabase

                        function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                            if(status === 1) {
                                textPatientTitle.text = qtObjectEditInformation.patientID + " | " + firstName + " " + lastName;
                            }
                        }

                        function onFinishedUpdatingPatientBasicInformation(status: int, message: string) {
                            if(status === 1) {
                                textPatientTitle.text = qtObjectEditInformation.patientID + " | " + textFieldFirstName.text + " " + textFieldLastName.text;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientBasicInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("اطلاعات پایه بیمار")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientBasicInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("برای ویرایش اطلاعات پایه بیمار می‌توان از فیلدهای زیر استفاده کرد.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("نام")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldFirstName

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[\p{L}]+(?:[ '\-][\p{L}]+)*$/u
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    textFieldFirstName.text = firstName;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("نام خانوادگی")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldLastName

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[\p{L}]+(?: [\p{L}]+)*$/u
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    textFieldLastName.text = lastName;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("سال تولد")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldBirthYear

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: IntValidator {
                            top: 9999
                            bottom: 0
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    textFieldBirthYear.text = birthYear;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("شماره تلفن")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldPhoneNumber

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[0-9][0-9]{1,14}$/
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    textFieldPhoneNumber.text = phoneNumber;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("آدرس ایمیل")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldEmail

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[^\s@]+@[^\s@]+\.com$/
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    textFieldEmail.text = email;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("جنسیت")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOComboBox {
                        id: comboBoxGender

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        currentIndex: 0
                        model: ["نامشخص", "مرد", "زن"]

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    switch (gender) {
                                    case "نامشخص":
                                        comboBoxGender.currentIndex = 0;
                                        break;
                                    case "مرد":
                                        comboBoxGender.currentIndex = 1;
                                        break;
                                    case "زن":
                                        comboBoxGender.currentIndex = 2;
                                        break;
                                    default:
                                        break;
                                    };
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("وضعیت تاهل")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOComboBox {
                        id: comboBoxMaritalStatus

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        currentIndex: 0
                        model: ["نامشخص", "مجرد", "متاهل"]

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientBasicInformation(status: int, message: string, firstName: string, lastName: string, birthYear: int, phoneNumber: string, email: string, gender: string, maritalStatus: string) {
                                if(status === 1) {
                                    switch (gender) {
                                    case "نامشخص":
                                        comboBoxMaritalStatus.currentIndex = 0;
                                        break;
                                    case "مجرد":
                                        comboBoxMaritalStatus.currentIndex = 1;
                                        break;
                                    case "متاهل":
                                        comboBoxMaritalStatus.currentIndex = 2;
                                        break;
                                    default:
                                        break;
                                    };
                                }
                            }
                        }
                    }

                    UFOButton {
                        id: buttonUpdatePatientBasicInformation

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35
                        Layout.topMargin: 20

                        display: AbstractButton.TextBesideIcon
                        text: qsTr("ذخیره کردن")
                        icon.source: "qrc:/resources/icons/material/save.svg"

                        onClicked: {
                            if (!textFieldFirstName.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی نام صحیح نیست.") + "\n" + qsTr("لطفاً قبل از ادامه نام صحیح را وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (!textFieldLastName.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی نام خانوادگی صحیح نیست.") + "\n" + qsTr("لطفاً قبل از ادامه نام خانوادگی صحیح را وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (!textFieldBirthYear.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به فیلد ورودی سال تولد صحیح نیست.") + "\n" + qsTr("لطفاً قبل از ادامه، سال تولد صحیح را ارائه دهید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (!textFieldPhoneNumber.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی شماره تلفن صحیح نیست.") + "\n" + qsTr("لطفاً قبل از ادامه یک شماره تلفن صحیح ارائه دهید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (textFieldEmail.text !== "" && !textFieldEmail.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی آدرس ایمیل صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک آدرس ایمیل صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            let newFirstName = textFieldFirstName.text;
                            let newLastName = textFieldLastName.text;
                            let newBirthYear = parseInt(textFieldBirthYear.text, 10);
                            let newPhoneNumber = textFieldPhoneNumber.text;
                            let newEmail = textFieldEmail.text;
                            let newGender = comboBoxGender.currentText;
                            let newMaritalStatus = comboBoxMaritalStatus.currentText;

                            mainDatabase.updatePatientBasicInformation(
                                qtObjectEditInformation.patientID,
                                newFirstName,
                                newLastName,
                                newBirthYear,
                                newPhoneNumber,
                                newEmail,
                                newGender,
                                newMaritalStatus
                            );
                        }

                        Connections {
                            target: mainDatabase

                            function onStartedUpdatingPatientBasicInformation() {
                                buttonUpdatePatientBasicInformation.enabled = false;
                            }

                            function onFinishedUpdatingPatientBasicInformation(status: int, message: string) {
                                buttonUpdatePatientBasicInformation.enabled = true;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientVisitInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("اطلاعات ویزیت")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientVisitInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر می‌توانند برای تغییر اطلاعات ویزیت بیمار استفاده شوند. لطفاً توجه داشته باشید که تاریخ و زمان باید با فرمت 'yyyy-mm-dd' وارد شوند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("تعداد مراجعه های قبلی")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldNumberOfPreviousVisits

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: IntValidator {
                            top: 65535
                            bottom: 0
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientVisitInformation(status: int, message: string, numberOfPreviousVisits: int, firstVisitDate: string, recentVisitDate: string, expectedVisitDate: string) {
                                if(status === 1) {
                                    textFieldNumberOfPreviousVisits.text = numberOfPreviousVisits;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("تاریخ اولین بازدید")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldFirstVisitDate

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientVisitInformation(status: int, message: string, numberOfPreviousVisits: int, firstVisitDate: string, recentVisitDate: string, expectedVisitDate: string) {
                                if(status === 1) {
                                    textFieldFirstVisitDate.text = firstVisitDate;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("تاریخ آخرین بازدید")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldRecentVisitDate

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientVisitInformation(status: int, message: string, numberOfPreviousVisits: int, firstVisitDate: string, recentVisitDate: string, expectedVisitDate: string) {
                                if(status === 1) {
                                    textFieldRecentVisitDate.text = recentVisitDate;
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("تاریخ مورد انتظار ویزیت")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldExpectedVisitDate

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: RegularExpressionValidator {
                            regularExpression: /^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientVisitInformation(status: int, message: string, numberOfPreviousVisits: int, firstVisitDate: string, recentVisitDate: string, expectedVisitDate: string) {
                                if(status === 1) {
                                    textFieldExpectedVisitDate.text = expectedVisitDate;
                                }
                            }
                        }
                    }

                    UFOButton {
                        id: buttonUpdatePatientVisitInformation

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35
                        Layout.topMargin: 20

                        display: AbstractButton.TextBesideIcon
                        text: qsTr("ذخیره کردن")
                        icon.source: "qrc:/resources/icons/material/save.svg"

                        onClicked: {
                            if (!textFieldNumberOfPreviousVisits.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی تعداد مراجعه های قبلی صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک تعداد مراجعه های قبلی صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (textFieldFirstVisitDate.text !== "" && !textFieldFirstVisitDate.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی تاریخ اولین بازدید صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک تاریخ اولین بازدید صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (textFieldRecentVisitDate.text !== "" && !textFieldRecentVisitDate.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی تاریخ آخرین بازدید صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک تاریخ آخرین بازدید صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (textFieldExpectedVisitDate.text !== "" && !textFieldExpectedVisitDate.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی تاریخ مورد انتظار ویزیت صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک تاریخ مورد انتظار ویزیت صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            let newNumberOfPreviousVisits = parseInt(textFieldNumberOfPreviousVisits.text, 10);
                            let newFirstVisitDate = textFieldFirstVisitDate.text;
                            let newRecentVisitDate = textFieldRecentVisitDate.text;
                            let newExpectedVisitDate = textFieldExpectedVisitDate.text;

                            mainDatabase.updatePatientVisitInformation(
                                qtObjectEditInformation.patientID,
                                newNumberOfPreviousVisits,
                                newFirstVisitDate,
                                newRecentVisitDate,
                                newExpectedVisitDate,
                            );
                        }

                        Connections {
                            target: mainDatabase

                            function onStartedUpdatingPatientVisitInformation() {
                                buttonUpdatePatientVisitInformation.enabled = false;
                            }

                            function onFinishedUpdatingPatientVisitInformation(status: int, message: string) {
                                buttonUpdatePatientVisitInformation.enabled = true;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientPaymentInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("اطلاعات پرداخت")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientPaymentInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("برای تغییر اطلاعات پرداخت بیمار از فیلدهای زیر استفاده کنید.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("قیمت خدمات پزشکی")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldServicePrice

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: DoubleValidator {
                            bottom: 0.00
                            decimals: 3
                            notation: DoubleValidator.StandardNotation
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientPaymentInformation(status: int, message: string, servicePrice: real, paidPrice: real) {
                                if(status === 1) {
                                    textFieldServicePrice.text = servicePrice.toFixed(3);
                                }
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("هزینه پرداخت شده توسط بیمار")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.NoWrap
                    }

                    UFOTextField {
                        id: textFieldPaidPrice

                        Layout.preferredWidth: 250
                        Layout.preferredHeight: 35

                        horizontalAlignment: TextInput.AlignLeft
                        validator: DoubleValidator {
                            bottom: 0.00
                            decimals: 3
                            notation: DoubleValidator.StandardNotation
                        }

                        Connections {
                            target: mainDatabase

                            function onFinishedGettingPatientPaymentInformation(status: int, message: string, servicePrice: real, paidPrice: real) {
                                if(status === 1) {
                                    textFieldPaidPrice.text = paidPrice.toFixed(3);
                                }
                            }
                        }
                    }

                    UFOButton {
                        id: buttonUpdatePatientPaymentInformation

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35
                        Layout.topMargin: 20

                        display: AbstractButton.TextBesideIcon
                        text: qsTr("ذخیره کردن")
                        icon.source: "qrc:/resources/icons/material/save.svg"

                        onClicked: {
                            if (!textFieldServicePrice.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی قیمت خدمات پزشکی صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک قیمت صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            if (!textFieldPaidPrice.acceptableInput) {
                                mainDialog.title = qsTr("ورودی ارائه شده به قسمت ورودی هزینه پرداخت شده توسط بیمار صحیح نیست.") + "\n" + qsTr("لطفا قبل از ادامه یک هزینه صحیح وارد کنید.");
                                mainDialog.identifier = "Edit";
                                mainDialog.standardButtons = Dialog.Ok;
                                mainDialog.modal = true;
                                mainDialog.open();

                                return;
                            }

                            let newServicePrice = parseFloat(textFieldServicePrice.text);
                            let newPaidPrice = parseFloat(textFieldPaidPrice.text);

                            mainDatabase.updatePatientPaymentInformation(
                                qtObjectEditInformation.patientID,
                                newServicePrice,
                                newPaidPrice
                            );
                        }

                        Connections {
                            target: mainDatabase

                            function onStartedUpdatingPatientPaymentInformation() {
                                buttonUpdatePatientVisitInformation.enabled = false;
                            }

                            function onFinishedUpdatingPatientPaymentInformation(status: int, message: string) {
                                buttonUpdatePatientVisitInformation.enabled = true;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientDiagnosesInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("تشخیص‌ها")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientDiagnosesInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر امکان کنترل تشخیص‌های مرتبط با بیمار را فراهم می‌کنند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        spacing: 5

                        UFOComboBox {
                            id: comboBoxDiagnosesList

                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 35

                            DiagnosesListModel {
                                id: diagnosesListModel

                                database: mainDatabase
                            }

                            ProxyFilter {
                                id: proxyFilterDiagnosesList
                                sourceModel: diagnosesListModel
                                roleText: "name"
                                filterValue: comboBoxDiagnosesList.filterText
                                sensitivityStatus: false
                            }

                            canFilter: true
                            textRole: "name"
                            model: proxyFilterDiagnosesList
                        }

                        UFOButton {
                            Layout.preferredWidth: 120
                            Layout.preferredHeight: 35

                            display: AbstractButton.TextBesideIcon
                            text: qsTr("اضافه کردن")
                            icon.source: "qrc:/resources/icons/material/add.svg"

                            onClicked: {
                                let targetItem = proxyFilterDiagnosesList.get(comboBoxDiagnosesList.currentIndex);

                                // NOTE (SAVIZ): Sometimes due to 'ProxyFilter', the comboBox may return undefined values (either because nothing is selected or some other random wierd stuff) and I don't know how to prevent that. For now I will just make a safety check:
                                if (targetItem["diagnosisID"] === undefined) {
                                    return;
                                }

                                patientDiagnosesModel.requestInsertPatientDiagnosis(
                                    qtObjectEditInformation.patientID,
                                    targetItem["diagnosisID"],
                                    targetItem["name"]
                                );
                            }
                        }
                    }

                    ListView {
                        id: listViewPatientDiagnoses

                        Layout.fillWidth: true
                        Layout.preferredHeight: 300

                        clip: true
                        spacing: 7

                        PatientDiagnosesModel {
                            id: patientDiagnosesModel

                            database: mainDatabase
                        }

                        model: patientDiagnosesModel

                        delegate: DiagnosisDelegate {
                            width: listViewPatientDiagnoses.width

                            onDeleteClicked: function(diagnosisID, row) {
                                patientDiagnosesModel.requestRemovePatientDiagnosis(qtObjectEditInformation.patientID, diagnosisID, row);
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.topMargin: 20
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("ناحیه متنی زیر امکان تغییر هرگونه یادداشت مربوط به تشخیص‌ها را فراهم می‌کند. برای تأیید متن جدید، کافیست دکمه را برای ذخیره تغییرات فشار دهید.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200

                        // ScrollBar.vertical: UFO_ScrollBar {
                        //     parent: scrollView

                        //     x: scrollView.mirrored ? 0 : scrollView.width - width
                        //     y: scrollView.topPadding

                        //     height: scrollView.availableHeight
                        //     active: scrollView.ScrollBar.horizontal.active
                        // }

                        UFOTextArea {
                            id: textAreaDiagnosesNote

                            Connections {
                                target: mainDatabase

                                function onFinishedGettingPatientDiagnosesNote(status: int, message: string, note: string) {
                                    if(status === 1) {
                                        textAreaDiagnosesNote.text = note;
                                    }
                                }
                            }
                        }
                    }

                    UFOButton {
                        id: buttonUpdatePatientDiagnosesNote

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35
                        Layout.topMargin: 20

                        display: AbstractButton.TextBesideIcon
                        text: qsTr("ذخیره کردن")
                        icon.source: "qrc:/resources/icons/material/save.svg"

                        onClicked: {
                            // NOTE (SAVIZ): It is up to the user to decide what the text should be, including the option to leave it empty.
                            let newNote = textAreaDiagnosesNote.text;

                            mainDatabase.updatePatientDiagnosesNote(
                                qtObjectEditInformation.patientID,
                                newNote
                            );
                        }

                        Connections {
                            target: mainDatabase

                            function onStartedUpdatingPatientDiagnosesNote() {
                                buttonUpdatePatientDiagnosesNote.enabled = false;
                            }

                            function onFinishedUpdatingPatientDiagnosesNote(status: int, message: string) {
                                buttonUpdatePatientDiagnosesNote.enabled = true;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientTreatmentsInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("درمان ها")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientTreatmentsInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر امکان تغییر درمان ها مرتبط با بیمار را فراهم می‌کنند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        spacing: 5

                        UFOComboBox {
                            id: comboBoxTreatmentsList

                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 35

                            TreatmentsListModel {
                                id: treatmentsListModel

                                database: mainDatabase
                            }

                            ProxyFilter {
                                id: proxyFilterTreatmentsList
                                sourceModel: treatmentsListModel
                                roleText: "name"
                                filterValue: comboBoxTreatmentsList.filterText
                                sensitivityStatus: false
                            }

                            canFilter: true
                            textRole: "name"
                            model: proxyFilterTreatmentsList
                        }

                        UFOButton {
                            Layout.preferredWidth: 120
                            Layout.preferredHeight: 35

                            display: AbstractButton.TextBesideIcon
                            text: qsTr("اضافه کردن")
                            icon.source: "qrc:/resources/icons/material/add.svg"

                            onClicked: {
                                let targetItem = proxyFilterTreatmentsList.get(comboBoxTreatmentsList.currentIndex);

                                // NOTE (SAVIZ): Sometimes due to 'ProxyFilter', the comboBox may return undefined values (either because nothing is selected or some other random wierd stuff) and I don't know how to prevent that. For now I will just make a safety check:
                                if (targetItem["treatmentID"] === undefined) {
                                    return;
                                }

                                patientTreatmentsModel.requestInsertPatientTreatment(
                                    qtObjectEditInformation.patientID,
                                    targetItem["treatmentID"],
                                    targetItem["name"]
                                );
                            }
                        }
                    }

                    ListView {
                        id: listViewPatientTreatments

                        Layout.fillWidth: true
                        Layout.preferredHeight: 300

                        clip: true
                        spacing: 7

                        PatientTreatmentsModel {
                            id: patientTreatmentsModel

                            database: mainDatabase
                        }

                        model: patientTreatmentsModel

                        delegate: TreatmentDelegate {
                            width: listViewPatientTreatments.width

                            onDeleteClicked: function(treatmentID, row) {
                                patientTreatmentsModel.requestRemovePatientTreatment(qtObjectEditInformation.patientID, treatmentID, row);
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.topMargin: 20
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("ناحیه متنی زیر امکان تغییر هرگونه یادداشت مربوط به درمان‌ها را فراهم می‌کند. برای تأیید متن جدید، کافیست دکمه را برای ذخیره تغییرات فشار دهید.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200

                        // ScrollBar.vertical: UFO_ScrollBar {
                        //     parent: scrollView

                        //     x: scrollView.mirrored ? 0 : scrollView.width - width
                        //     y: scrollView.topPadding

                        //     height: scrollView.availableHeight
                        //     active: scrollView.ScrollBar.horizontal.active
                        // }

                        UFOTextArea {
                            id: textAreaTreatmentsNote

                            Connections {
                                target: mainDatabase

                                function onFinishedGettingPatientTreatmentsNote(status: int, message: string, note: string) {
                                    if(status === 1) {
                                        textAreaTreatmentsNote.text = note;
                                    }
                                }
                            }
                        }
                    }

                    UFOButton {
                        id: buttonUpdatePatientTreatmentsNote

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35
                        Layout.topMargin: 20

                        display: AbstractButton.TextBesideIcon
                        text: qsTr("ذخیره کردن")
                        icon.source: "qrc:/resources/icons/material/save.svg"

                        onClicked: {
                            // NOTE (SAVIZ): It is up to the user to decide what the text should be. Even if the text is empty.
                            let newNote = textAreaTreatmentsNote.text;

                            mainDatabase.updatePatientTreatmentsNote(
                                qtObjectEditInformation.patientID,
                                newNote
                            );
                        }

                        Connections {
                            target: mainDatabase

                            function onStartedUpdatingPatientTreatmentsNote() {
                                buttonUpdatePatientTreatmentsNote.enabled = false;
                            }

                            function onFinishedUpdatingPatientTreatmentsNote(status: int, message: string) {
                                buttonUpdatePatientTreatmentsNote.enabled = true;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientProceduresInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("پروسیجر ها")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientProceduresInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر امکان تغییر پروسیجر ها مرتبط با بیمار را فراهم می‌کنند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        spacing: 5

                        UFOComboBox {
                            id: comboBoxProceduresList

                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 35

                            ProceduresListModel {
                                id: proceduresListModel

                                database: mainDatabase
                            }

                            ProxyFilter {
                                id: proxyFilterProceduresList
                                sourceModel: proceduresListModel
                                roleText: "name"
                                filterValue: comboBoxProceduresList.filterText
                                sensitivityStatus: false
                            }

                            canFilter: true
                            textRole: "name"
                            model: proxyFilterProceduresList
                        }

                        UFOButton {
                            Layout.preferredWidth: 120
                            Layout.preferredHeight: 35

                            display: AbstractButton.TextBesideIcon
                            text: qsTr("اضافه کردن")
                            icon.source: "qrc:/resources/icons/material/add.svg"

                            onClicked: {
                                let targetItem = proxyFilterProceduresList.get(comboBoxProceduresList.currentIndex);

                                // NOTE (SAVIZ): Sometimes due to 'ProxyFilter', the comboBox may return undefined values (either because nothing is selected or some other random wierd stuff) and I don't know how to prevent that. For now I will just make a safety check:
                                if (targetItem["procedureID"] === undefined) {
                                    return;
                                }

                                patientProceduresModel.requestInsertPatientProcedure(
                                    qtObjectEditInformation.patientID,
                                    targetItem["procedureID"],
                                    targetItem["name"]
                                );
                            }
                        }
                    }

                    ListView {
                        id: listViewPatientProcedures

                        Layout.fillWidth: true
                        Layout.preferredHeight: 300

                        clip: true
                        spacing: 7

                        PatientProceduresModel {
                            id: patientProceduresModel

                            database: mainDatabase
                        }

                        model: patientProceduresModel

                        delegate: ProcedureDelegate {
                            width: listViewPatientProcedures.width

                            onDeleteClicked: function(procedureID, row) {
                                patientProceduresModel.requestRemovePatientProcedure(qtObjectEditInformation.patientID, procedureID, row);
                            }

                            onUpdateClicked: function(procedureID, newFee, row) {
                                patientProceduresModel.requestUpdatePatientProcedureFee(qtObjectEditInformation.patientID, procedureID, newFee, row);
                            }
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.topMargin: 20
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("ناحیه متنی زیر امکان تغییر هرگونه یادداشت مربوط به درمان‌ها را فراهم می‌کند. برای تأیید متن جدید، کافیست دکمه را برای ذخیره تغییرات فشار دهید.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    ScrollView {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 200

                        // ScrollBar.vertical: UFO_ScrollBar {
                        //     parent: scrollView

                        //     x: scrollView.mirrored ? 0 : scrollView.width - width
                        //     y: scrollView.topPadding

                        //     height: scrollView.availableHeight
                        //     active: scrollView.ScrollBar.horizontal.active
                        // }

                        UFOTextArea {
                            id: textAreaProceduresNote

                            Connections {
                                target: mainDatabase

                                function onFinishedGettingPatientProceduresNote(status: int, message: string, note: string) {
                                    if(status === 1) {
                                        textAreaProceduresNote.text = note;
                                    }
                                }
                            }
                        }
                    }

                    UFOButton {
                        id: buttonUpdatePatientProceduresNote

                        Layout.preferredWidth: 120
                        Layout.preferredHeight: 35
                        Layout.topMargin: 20

                        display: AbstractButton.TextBesideIcon
                        text: qsTr("ذخیره کردن")
                        icon.source: "qrc:/resources/icons/material/save.svg"

                        onClicked: {
                            // NOTE (SAVIZ): It is up to the user to decide what the text should be. Even if the text is empty.
                            let newNote = textAreaProceduresNote.text;

                            mainDatabase.updatePatientProceduresNote(
                                qtObjectEditInformation.patientID,
                                newNote
                            );
                        }

                        Connections {
                            target: mainDatabase

                            function onStartedUpdatingPatientProceduresNote() {
                                buttonUpdatePatientTreatmentsNote.enabled = false;
                            }

                            function onFinishedUpdatingPatientProceduresNote(status: int, message: string) {
                                buttonUpdatePatientTreatmentsNote.enabled = true;
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientConsultationsInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("مشاوره ها")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientConsultationsInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر امکان تغییر مشاوره ها مرتبط با بیمار را فراهم می‌کنند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        spacing: 5

                        UFOComboBox {
                            id: comboBoxConsultantsList

                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 35

                            ConsultantsListModel {
                                id: consultantsListModel

                                database: mainDatabase
                            }

                            ProxyFilter {
                                id: proxyFilterConsultantsList
                                sourceModel: consultantsListModel
                                roleText: "name"
                                filterValue: comboBoxConsultantsList.filterText
                                sensitivityStatus: false
                            }

                            canFilter: true
                            textRole: "name"
                            model: proxyFilterConsultantsList
                        }

                        UFOButton {
                            Layout.preferredWidth: 120
                            Layout.preferredHeight: 35

                            display: AbstractButton.TextBesideIcon
                            text: qsTr("اضافه کردن")
                            icon.source: "qrc:/resources/icons/material/add.svg"

                            onClicked: {
                                let targetItem = proxyFilterConsultantsList.get(comboBoxConsultantsList.currentIndex);

                                // NOTE (SAVIZ): Sometimes due to 'ProxyFilter', the comboBox may return undefined values (either because nothing is selected or some other random wierd stuff) and I don't know how to prevent that. For now I will just make a safety check:
                                if (targetItem["consultantID"] === undefined) {
                                    return;
                                }

                                patientConsultationsModel.requestInsertPatientConsultation(
                                    qtObjectEditInformation.patientID,
                                    targetItem["consultantID"]
                                );
                            }
                        }
                    }

                    ListView {
                        id: listViewPatientConsultations

                        Layout.fillWidth: true
                        Layout.preferredHeight: 300

                        clip: true
                        spacing: 7

                        PatientConsultationsModel {
                            id: patientConsultationsModel

                            database: mainDatabase
                        }

                        model: patientConsultationsModel

                        delegate: ConsultationDelegate {
                            width: listViewPatientConsultations.width

                            onDeleteClicked: function(row) {
                                patientConsultationsModel.requestRemovePatientConsultation(row);
                            }

                            onUpdateClicked: function(consultationID, newDate, newOutcome, row) {
                                patientConsultationsModel.requestUpdatePatientConsultationDateAndOutcome(consultationID, newDate, newOutcome, row);
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientLabsInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("آزمایشگاه‌ها")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientLabsInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر امکان تغییر آزمایشگاه‌ها مرتبط با بیمار را فراهم می‌کنند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        spacing: 5

                        UFOComboBox {
                            id: comboBoxLabsList

                            Layout.preferredWidth: 250
                            Layout.preferredHeight: 35

                            LabsListModel {
                                id: labsListModel

                                database: mainDatabase
                            }

                            ProxyFilter {
                                id: proxyFilterLabsList
                                sourceModel: labsListModel
                                roleText: "name"
                                filterValue: comboBoxLabsList.filterText
                                sensitivityStatus: false
                            }

                            canFilter: true
                            textRole: "name"
                            model: proxyFilterLabsList
                        }

                        UFOButton {
                            Layout.preferredWidth: 120
                            Layout.preferredHeight: 35

                            display: AbstractButton.TextBesideIcon
                            text: qsTr("اضافه کردن")
                            icon.source: "qrc:/resources/icons/material/add.svg"

                            onClicked: {
                                let targetItem = proxyFilterLabsList.get(comboBoxLabsList.currentIndex);

                                // NOTE (SAVIZ): Sometimes due to 'ProxyFilter', the comboBox may return undefined values (either because nothing is selected or some other random wierd stuff) and I don't know how to prevent that. For now I will just make a safety check:
                                if (targetItem["labID"] === undefined) {
                                    return;
                                }

                                patientLabTestsModel.requestInsertPatientLabTest(
                                    qtObjectEditInformation.patientID,
                                    targetItem["labID"]
                                );
                            }
                        }
                    }

                    ListView {
                        id: listViewPatientLabTests

                        Layout.fillWidth: true
                        Layout.preferredHeight: 300

                        clip: true
                        spacing: 7

                        PatientLabTestsModel {
                            id: patientLabTestsModel

                            database: mainDatabase
                        }

                        model: patientLabTestsModel

                        delegate: LabTestDelegate {
                            width: listViewPatientLabTests.width

                            onDeleteClicked: function(labTestID, row) {
                                patientLabTestsModel.requestRemovePatientLabTest(labTestID, row);
                            }

                            onUpdateClicked: function(labTestID, newDate, newOutcome, CBC,
                                                      WBC,
                                                      Hgb,
                                                      Ferritin,
                                                      ESR,
                                                      Na,
                                                      K,
                                                      Mg,
                                                      VitaminD,
                                                      FBS,
                                                      TG,
                                                      Cholestrol,
                                                      AST,
                                                      ALT,
                                                      ALKPh,
                                                      BUN,
                                                      Cr,
                                                      UA,
                                                      SE_OB,
                                                      SE_OP,
                                                      H_Pylori_Ab,
                                                      H_Pylori_Ag_SE,
                                                      Tuberculin_test,
                                                      Pathergy_test,
                                                      Sonography,
                                                      TSH,
                                                      LH,
                                                      FSH,
                                                      DHEAS,
                                                      OH_P_17,
                                                      Prolactine,
                                                      Testosterone,
                                                      Hepatitis_Ag,
                                                      Hepatitis_Ab,
                                                      ANA,
                                                      Anti_DS_Ab,
                                                      Anti_SCL70_Ab,
                                                      IgE,row) {
                                patientLabTestsModel.requestUpdatePatientLabTest(labTestID, newDate, newOutcome, CBC,
                                                                                                         WBC,
                                                                                                         Hgb,
                                                                                                         Ferritin,
                                                                                                         ESR,
                                                                                                         Na,
                                                                                                         K,
                                                                                                         Mg,
                                                                                                         VitaminD,
                                                                                                         FBS,
                                                                                                         TG,
                                                                                                         Cholestrol,
                                                                                                         AST,
                                                                                                         ALT,
                                                                                                         ALKPh,
                                                                                                         BUN,
                                                                                                         Cr,
                                                                                                         UA,
                                                                                                         SE_OB,
                                                                                                         SE_OP,
                                                                                                         H_Pylori_Ab,
                                                                                                         H_Pylori_Ag_SE,
                                                                                                         Tuberculin_test,
                                                                                                         Pathergy_test,
                                                                                                         Sonography,
                                                                                                         TSH,
                                                                                                         LH,
                                                                                                         FSH,
                                                                                                         DHEAS,
                                                                                                         OH_P_17,
                                                                                                         Prolactine,
                                                                                                         Testosterone,
                                                                                                         Hepatitis_Ag,
                                                                                                         Hepatitis_Ab,
                                                                                                         ANA,
                                                                                                         Anti_DS_Ab,
                                                                                                         Anti_SCL70_Ab,
                                                                                                         IgE, row);
                            }
                        }
                    }
                }

                UFOSection {
                    id: sectionPatientImagesInformation

                    Layout.fillWidth: true

                    startCollapsed: true
                    enabled: false
                    title: qsTr("تصاویر")

                    Connections {
                        target: root

                        function onFinishedLoadingPatientForEditing(isSuccessful: bool) {
                            sectionPatientImagesInformation.enabled = isSuccessful;
                        }
                    }

                    Text {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        color: AppTheme.getColor(AppTheme.Colors.SectionContentText)
                        elide: Text.ElideRight
                        text: qsTr("فیلدهای زیر امکان تغییر تصاویر مرتبط با بیمار را فراهم می‌کنند.")
                        textFormat: Text.PlainText
                        verticalAlignment: Text.AlignVCenter
                        wrapMode: Text.Wrap
                    }

                    RowLayout {
                        Layout.fillWidth: true
                        Layout.bottomMargin: 20

                        spacing: 5

                        FileDialog {
                            id: fileDialog

                            title: "انتخاب تصویر"
                            fileMode: FileDialog.OpenFile
                            nameFilters: ["Image Files (*.png *.jpg *.jpeg)"]
                            currentFolder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)

                            onAccepted: {
                                patientImagesModel.requestInsertPatientImage(qtObjectEditInformation.patientID, fileDialog.selectedFile);
                            }
                        }

                        UFOButton {
                            Layout.preferredWidth: 120
                            Layout.preferredHeight: 35

                            display: AbstractButton.TextBesideIcon
                            text: qsTr("انتخاب تصویر")
                            icon.source: "qrc:/resources/icons/material/add.svg"

                            onClicked: {
                                fileDialog.open()
                            }
                        }
                    }

                    ListView {
                        id: listViewPatientImagess

                        Layout.fillWidth: true
                        Layout.preferredHeight: 300

                        clip: true
                        spacing: 7

                        PatientImagesModel {
                            id: patientImagesModel

                            database: mainDatabase
                        }

                        model: patientImagesModel

                        delegate: ImageDelegate {
                            width: listViewPatientImagess.width

                            onDeleteClicked: function(imageName, row) {
                                patientImagesModel.requestRemovePatientImage(qtObjectEditInformation.patientID, imageName, row);
                            }

                            onUpdateClicked: function(name, newName, row) {
                                patientImagesModel.requestUpdatePatientImageName(qtObjectEditInformation.patientID, name, newName, row);
                            }

                            onViewClicked: function(row) {
                                let imageUrl = patientImagesModel.getImage(row);

                                let component = Qt.createComponent("./UFOFullScreen.qml");

                                if (component.status === Component.Ready) {
                                    var fullscreen = component.createObject(root, {
                                    "imageUrl": imageUrl
                                    });
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
