Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9427474CE
	for <lists+linux-sctp@lfdr.de>; Sun, 16 Jun 2019 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfFPNjX (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 16 Jun 2019 09:39:23 -0400
Received: from mailout2.dotplex.com ([185.231.124.20]:56349 "EHLO
        mailout2.dotplex.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfFPNjW (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 16 Jun 2019 09:39:22 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Jun 2019 09:39:22 EDT
Received: from remote.ip.hidden (remote.ip.hidden [127.0.0.1])
        (Authenticated sender: estellnb@elstel.org)
        by mailout.dotplex.com (Postfix) with ESMTPSA id 519CA20144
        for <linux-sctp@vger.kernel.org>; Sun, 16 Jun 2019 15:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elstel.org;
        s=dotplex190506; t=1560692003;
        bh=Jjl3n52o86/bQpEjNb1uDbHzqfiPyGxS6CxumMEsMCU=;
        h=From:Subject:To:Date:From;
        b=eoYqjMKXrfH4IY4fUqQtdRQuFDOmUjDmB5TrNkKWh/6OIpC4yeHJsn8EAhsGFMhje
         f1rpVJthdVJDw22jpHh5dqTH+9dLTdVlXcnGscczKZ5+VkoG8UhksjBW+dzwzblofi
         K/96x0727OyV0Mn1eZfHModwvGUndxiZxYEPLFbhBKTRyceSCOfkeLZDgZi+ALsv/9
         6ljW84QrpzaJF0qe53Z0eBX8/V4ZysIDQaF/3C8fB1ti58IWevvA2jlQBuohhUEAPt
         gBP2Ffsd2omG1s+Hgzv8TRRDLEliI/en5sdiNNRkPPF0nzxByo7k+noWa6lAIuTD5l
         IT+PAw+Co1ZEA==
From:   Elmar Stellnberger <estellnb@elstel.org>
Subject: sctp_sendmsg does not accept flags
To:     linux-sctp@vger.kernel.org
Message-ID: <e863ee11-9e1f-71b9-1f61-b4b71d9f0945@elstel.org>
Date:   Sun, 16 Jun 2019 15:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

    While sctp_send works well at me, sctp_sendmsg gives me an EINVAL as 
soon as I pass in some flags. Nonetheless it still sends the message in 
spite of returning the EINVAL. That looks like an error to me. Please 
investigate the issue.

while( len > 0 && ( ( ret = sctp_sendmsg( sid, bufp, len, NULL, 0, 0, 
MSG_NOSIGNAL, (0), 1000, 0 ) ) >= 0 || ( ret==-1 && ( errno == EINTR || 
errno == ENOBUFS ) ) ) ) {  // returns EINVAL if flags are passed
     if( ret >= 0 ) { bufp += ret; len -= ret; } else if( errno == 
ENOBUFS ) { struct timespec ts; ts.tv_sec=0; ts.tv_nsec=10000; 
nanosleep(&ts,NULL); } }
if( ret == -1 ) perror ("error sending request to stream #(0)");

   If you should be interested I can send the whole sctp test client 
program.






