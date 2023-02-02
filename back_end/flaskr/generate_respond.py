class RespondDecider:
    def __init__(self, res):
        self.intent = res['intent']
        self.slots = res['slots']

    def extract_info(self):
        respond_str = f'I guess your intent is: {self.intent}.\n\nHere is key information:\n'

        for slot in self.slots:
            respond_str += slot + '\n'

        if self.intent == 'BookRoom':
            book_room(self.slots)
            respond_str += '\nYour room booking is done!'
        elif self.intent == 'CheckGrade':
            grade = check_grade(self.slots)
            respond_str += f'\nYour grade check is done! Your grade is {grade}'
        elif self.intent == 'CourseInfo':
            info_res = course_info(self.slots)
            respond_str += f'\nYour course info check is done! {info_res}'
        elif self.intent == 'ContactInfo':
            contact_info(self.slots)
            respond_str += '\nYour contact info check is done!'
        # UNK, cannot identify the item
        else:
            respond_str = f'Sorry. I cannot identify your task. Could you rephrase it so that I can understand?\n'
        print('###########################')
        print(respond_str)
        return respond_str

    def book_room(self):
        room_num = ''
        date = ''
        begin_time = ''
        end_time = ''

        for slot in self.slots:
            if 'B-room_name' in slot:
                room_num += slot.replace('B-room_name', '') + ' '
            elif 'I-room_name' in slot:
                room_num += slot.replace('I-room_name', '') + ' '
            elif 'B-room_begin_time' in slot:
                begin_time += slot.replace('B-room_begin_time', '') + ' '
            elif 'I-room_begin_time' in slot:
                begin_time += slot.replace('I-room_begin_time', '') + ' '
            elif 'B-room_date' in slot:
                date += slot.replace('B-room_date', '') + ' '
            elif 'I-room_date' in slot:
                date += slot.replace('I-room_date', '') + ' '
            elif 'B-room_end_time' in slot:
                end_time += slot.replace('B-room_end_time', '') + ' '
            elif 'I-room_end_time' in slot:
                end_time += slot.replace('I-room_end_time', '') + ' '

        book_room_api(room_num, date, begin_time, end_time)
        return 0

    def check_grade(self):
        code = ''
        item = ''
        for slot in self.slots:
            if 'B-grade_code' in slot:
                code += slot.replace('B-grade_code', '') + ' '
            elif 'I-grade_code' in slot:
                code += slot.replace('I-grade_code', '') + ' '
            elif 'B-grade_name' in slot:
                item += slot.replace('B-grade_name', '') + ' '
            elif 'I-grade_name' in slot:
                item += slot.replace('I-grade_name', '') + ' '

        grade = check_grade_api(code, item)
        return grade

    def course_info(self):
        code = ''
        item = ''
        for slot in self.slots:
            if 'B-course_info_target' in slot:
                item += slot.replace('B-course_info_target', '') + ' '
            elif 'I-course_info_target' in slot:
                item += slot.replace('I-course_info_target', '') + ' '
            elif 'B-course_info_code' in slot:
                code += slot.replace('B-course_info_code', '') + ' '
            elif 'I-course_info_code' in slot:
                code += slot.replace('I-course_info_code', '') + ' '

        respond = course_info_api(code, item)
        return respond

    def contact_info(self):
        title = ''
        name = ''
        for slot in self.slots:
            if 'B-contact_title' in slot:
                title += slot.replace('B-contact_title', '') + ' '
            elif 'I-contact_title' in slot:
                title += slot.replace('I-contact_title', '') + ' '
            elif 'B-contact_name' in slot:
                name += slot.replace('B-contact_name', '') + ' '
            elif 'I-contact_name' in slot:
                name += slot.replace('I-contact_name', '') + ' '

        respond = contact_info_api(title, name)
        return respond


def extract_info(nlg_res):
    intent = nlg_res['intent']
    slots = nlg_res['slots']

    respond_str = f'I guess your intent is: {intent}.\n\nHere is key information:\n'

    for slot in slots:
        respond_str += slot+'\n'

    if intent == 'BookRoom':
        book_room(slots)
        respond_str += '\nYour room booking is done!'
    elif intent =='CheckGrade':
        grade = check_grade(slots)
        respond_str += f'\nYour grade check is done! Your grade is {grade}'
    elif intent == 'CourseInfo':
        info_res = course_info(slots)
        respond_str += f'\nYour course info check is done! {info_res}'
    elif intent == 'ContactInfo':
        contact_info(slots)
        respond_str += '\nYour contact info check is done!'
    # UNK, cannot identify the item
    else:
        respond_str = f'Sorry. I cannot identify your task. Could you rephrase it so that I can understand?\n'
    print('###########################')
    print(respond_str)
    return respond_str


def book_room(slots):
    room_num = ''
    date = ''
    begin_time = ''
    end_time = ''

    for slot in slots:
        if 'B-room_name' in slot:
            room_num += slot.replace('B-room_name', '')+' '
        elif 'I-room_name' in slot:
            room_num += slot.replace('I-room_name', '') + ' '
        elif 'B-room_begin_time' in slot:
            begin_time += slot.replace('B-room_begin_time', '')+' '
        elif 'I-room_begin_time' in slot:
            begin_time += slot.replace('I-room_begin_time', '') + ' '
        elif 'B-room_date' in slot:
            date += slot.replace('B-room_date', '') + ' '
        elif 'I-room_date' in slot:
            date += slot.replace('I-room_date', '') + ' '
        elif 'B-room_end_time' in slot:
            end_time += slot.replace('B-room_end_time', '') + ' '
        elif 'I-room_end_time' in slot:
            end_time += slot.replace('I-room_end_time', '') + ' '

    book_room_api(room_num, date, begin_time, end_time)
    return 0


def check_grade(slots):
    code = ''
    item = ''
    for slot in slots:
        if 'B-grade_code' in slot:
            code += slot.replace('B-grade_code', '')+' '
        elif 'I-grade_code' in slot:
            code += slot.replace('I-grade_code', '') + ' '
        elif 'B-grade_name' in slot:
            item += slot.replace('B-grade_name', '')+' '
        elif 'I-grade_name' in slot:
            item += slot.replace('I-grade_name', '') + ' '

    grade = check_grade_api(code, item)
    return grade


def course_info(slots):
    code = ''
    item = ''
    for slot in slots:
        if 'B-course_info_target' in slot:
            item += slot.replace('B-course_info_target', '') + ' '
        elif 'I-course_info_target' in slot:
            item += slot.replace('I-course_info_target', '') + ' '
        elif 'B-course_info_code' in slot:
            code += slot.replace('B-course_info_code', '') + ' '
        elif 'I-course_info_code' in slot:
            code += slot.replace('I-course_info_code', '') + ' '

    respond = course_info_api(code, item)
    return respond


def contact_info(slots):
    title = ''
    name = ''
    for slot in slots:
        if 'B-contact_title' in slot:
            title += slot.replace('B-contact_title', '') + ' '
        elif 'I-contact_title' in slot:
            title += slot.replace('I-contact_title', '') + ' '
        elif 'B-contact_name' in slot:
            name += slot.replace('B-contact_name', '') + ' '
        elif 'I-contact_name' in slot:
            name += slot.replace('I-contact_name', '') + ' '

    respond = contact_info_api(title, name)
    return respond


# APIs for outside integration
def book_room_api(room_num, date, begin_time, end_time):
    return 0


def check_grade_api(code, item):
    return 86


def course_info_api(code, item):
    return "Your required info has been sent to your cityu email!"


def contact_info_api(title, name):
    return "Your required info has been sent to your cityu email!"
