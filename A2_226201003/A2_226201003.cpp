#include<bits/stdc++.h>

using namespace std;

//8 characters (padding included) (All UPPERCASE)
#define WORD 8

//Creating structure for instructions
struct instruction
{
	string label;
	string opcode;
	string operand;

	instruction(string label = "", string opcode = "", string operand = "")
	{
		this -> label = label;
		this -> opcode = opcode;
		this -> operand = operand;
	}
//to check comment i.e which starts with .
	bool is_comment()
	{
		return (label == ".");
	}
//to check label
	bool has_label()
	{
		return (label != "");
	}

};

//Mapping Mnemonic and Opcode
string OPTAB(string opcode)
{
	if(opcode == "LDA")	return "00";
	if(opcode == "LDX")	return "04";
	if(opcode == "LDL")	return "08";
	if(opcode == "STA")	return "0C";
	if(opcode == "STX")	return "10";
	if(opcode == "STL")	return "14";
	if(opcode == "LDCH")	return "50";
	if(opcode == "STCH")	return "54";
	if(opcode == "ADD")	return "18";
	if(opcode == "SUB")	return "1C";
	if(opcode == "MUL")	return "20";
	if(opcode == "DIV")	return "24";
	if(opcode == "COMP")	return "28";
	if(opcode == "J" || opcode == "JMP")	return "3C";
	if(opcode == "JLT"|| opcode == "JL")	return "38";
	if(opcode == "JEQ"|| opcode == "JE")	return "30";
	if(opcode == "JGT"|| opcode == "JG")	return "34";
	if(opcode == "JSUB")	return "48";
	if(opcode == "RSUB")	return "4C";
	if(opcode == "TIX")	return "2C";
	if(opcode == "TD")	return "E0";
	if(opcode == "RD")	return "D8";
	if(opcode == "WD")	return "DC";
	return "";
}


//Map for Symbol table (name,location)
map<string, int> SYMTAB;

//string modification removing space padding 
string strip(string s)
{
	s.erase(remove(s.begin(), s.end(), ' '), s.end());
	return s;
}

//function to Process structured command line-by-line
void process_line(string line, instruction* instr)
{
	string label, opcode, operand;
	label = strip(line.substr(0, WORD));
	if(label == ".")
		instr -> label = label;	
	else
	{
		opcode = strip(line.substr(WORD, WORD));
		operand = strip(line.substr(WORD * 2, WORD));
		instr -> label = label;
		instr -> opcode = opcode;
		instr -> operand = operand;
	}
}

string process_line_2(string line, instruction* instr)
{
	string label, opcode, operand, LOCCTR;
	LOCCTR = strip(line.substr(0, WORD));
	
	if(LOCCTR == ".")
	{
		label = strip(line.substr(0, WORD));
		instr -> label = label;	
		return "";
	}
	else
	{
		label = strip(line.substr(WORD, WORD));
		opcode = strip(line.substr(WORD * 2, WORD));
		operand = strip(line.substr(WORD * 3, WORD));
		instr -> label = label;
		instr -> opcode = opcode;
		instr -> operand = operand;
		return LOCCTR;
	}
}

//string formatting: str=>int(dec)=> hex

string format_number(string input, int width, bool hex)
{
	int num;
	if(hex)
		num = stoi(input, NULL, 16);
	else
		num = stoi(input);

	stringstream temp;
	temp <<  std::hex << std::uppercase << std::setfill('0') << std::setw(width) << num;
	return temp.str();
}

string format_name(string name, int width)
{
	stringstream temp;
	temp << std::left << std::setfill(' ') << std::setw(width) << name;
	return temp.str();
}


//PASS 1
int pass_1()
{
	fstream fin, fout;

	fin.open("input.txt", ios::in);
	fout.open("intermediate.txt", ios::out);

	int LOCCTR = 0, STADDR = 0, LENGTH;
	
	//TODO: error flag structure
	bool error = false;
	
	while(fin.good())
	{
		string line;
		getline(fin, line);

		instruction instr;
		process_line(line, &instr); 

		if(!instr.is_comment())
		{
			if(instr.opcode == "START")
			{
				STADDR = stoi(instr.operand, NULL, 16);
				LOCCTR = STADDR;
				fout << format_name(format_number(to_string(LOCCTR), 4, false), 8) << line << '\n';
			}
			else if(instr.opcode == "END")
			{
				LENGTH = LOCCTR - STADDR;
				fout << format_name("", 8) << line;
				break;
			}
			else
			{
				if(instr.has_label())
				{
					if(SYMTAB.find(instr.label) == SYMTAB.end())
						{SYMTAB[instr.label] = LOCCTR;
						//cout<<instr.label<<" : "<< format_number(to_string(LOCCTR), 4, false)<<endl;
						
						cout<<right<< setw(8)<<instr.label<<" :"<<right<<setw(5)<< format_number(to_string(LOCCTR), 4, false)<<endl;
						}
					else
					{
						error = true; // duplicate symbol
						cout << "duplicate symbol\n";
					}
				}


				fout << format_name(format_number(to_string(LOCCTR), 4, false), 8) << line << '\n';

				if(OPTAB(instr.opcode) != "")
					LOCCTR += 3;
				else if(instr.opcode == "WORD")
					LOCCTR += 3;
				else if(instr.opcode == "RESW")
					LOCCTR += 3 * stoi(instr.operand);
				else if(instr.opcode == "RESB")
					LOCCTR += stoi(instr.operand);
				else if(instr.opcode == "BYTE")
				{
					if(instr.operand[0] == 'C')
						LOCCTR += (instr.operand.length() - 3);
					if(instr.operand[0] == 'X')
						LOCCTR += (instr.operand.length() - 3) / 2;
				}
				else
				{
					error = true; // invalid operation code
					cout << "invalid operation code\n";
				}
			}

		}
		else
			fout << ".       "<<line << '\n';
	}



//Iteratively printing

/*
    map<string, int>::iterator itr;
    for(itr= SYMTAB.begin();itr!= SYMTAB.end();itr++)
    {
        cout<<itr->first<<" : "<<itr->second<<endl;
    }

*/



	return LENGTH;










}

//PASS 2
void pass_2(int LENGTH)
{
	fstream fin, fout, fout2;

	fin.open("intermediate.txt", ios::in);
	fout.open("output.txt", ios::out);
	fout2.open("listing.txt", ios::out);
	
	string text_record, staddr;
	bool error = false;

	while(fin.good())
	{
		string line;
		getline(fin, line);

		instruction instr;
		string LOCCTR = process_line_2(line, &instr); 
		

		if(!instr.is_comment())
		{
			if(instr.opcode == "START")
			{
				stringstream header;
				header << "H";
				header << format_name(instr.label, 6);
				header << format_number(instr.operand, 6, true);
				header << format_number(to_string(LENGTH), 6, false);
				fout << header.str() << '\n';
				fout2 << line << '\n';
			}
			else if(instr.opcode == "END")
			{
				if(text_record.length())
				{
					int length = (text_record.length()) / 2;
					fout << "T" << format_number(staddr, 6, true) << format_number(to_string(length), 2, false) << text_record << '\n';
				}
				stringstream end; 
				int first = SYMTAB[instr.operand];
				end << "E";
				end << format_number(to_string(first), 6, false);
				fout << end.str() << '\n';
				fout2 << line;
			}
			else
			{
				string obcode = "";
				if(OPTAB(instr.opcode) != "")
				{
					obcode = OPTAB(instr.opcode);
					if(instr.operand != "")
					{
						int operand = 0;
						if(instr.operand.find(",") != string::npos)
						{
							instr.operand.resize(instr.operand.find(","));
							operand += 32768;
						}
						if(SYMTAB.find(instr.operand) != SYMTAB.end())
						{
							operand += SYMTAB[instr.operand];
							obcode += format_number(to_string(operand), 4, false);
						}
						else
						{
							obcode += format_number("0", 4, false);
							error = true; // undefined symbol
							cout << "undefined symbol\n";
						}
					}
					else
					{
						obcode += format_number("0", 4, false);
					}
					fout2 << line <<"  "<< format_name(obcode, 10) << '\n';
				}
				else
				{
					if(instr.opcode == "BYTE")
					{
						if(instr.operand[0] == 'C')
						{
							string constant = instr.operand.substr(2, instr.operand.length() - 3);
							for(char ch : constant)
							{
								int x = ch;
								obcode += format_number(to_string(x), 2, false);
							}
						}
						else
						{
							string constant = instr.operand.substr(2, instr.operand.length() - 3);
							obcode += format_number(constant, constant.length(), true);
						}
					}	
					else if(instr.opcode == "WORD")
						obcode += format_number(instr.operand, 6, false);

					fout2 << line <<"  "<< format_name(obcode, 10) << '\n';
				}

				if(text_record.length() == 0)
				{
					staddr = LOCCTR;
				}

				if(text_record.length() + obcode.length() <= 60 && instr.opcode != "RESW" && instr.opcode != "RESB")
				{
					text_record += obcode;
				}
				else
				{
					if(text_record.length())
					{
						int length = (text_record.length()) / 2;
						fout << "T" << format_number(staddr, 6, true) << format_number(to_string(length), 2, false) << text_record << '\n';
						text_record = obcode;
						staddr = LOCCTR;
					}
				}
			}
		}
		else
			fout2 << line << '\n';


	}

}

//MAIN Function
int main()
{
	int LENGTH = pass_1();		//PASS 1
	pass_2(LENGTH);			//PASS 2
	return 0;
}
