Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF5F01A3
	for <lists+linux-sctp@lfdr.de>; Tue,  5 Nov 2019 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731025AbfKEPjg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 5 Nov 2019 10:39:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46958 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEPjg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 5 Nov 2019 10:39:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so14451297pfc.13
        for <linux-sctp@vger.kernel.org>; Tue, 05 Nov 2019 07:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=oI4dnL3WAxnsg3J7Mkvre3vscsKD8H/LsJSI/K9G/UE=;
        b=HpLo7KFhtHuu/crg6CxqmccLnhSG8YoN2ncA8MVhKYR0YDbtMRTD9F2kq9uuR64OgL
         wxVA5XfeeXAn7XFqL2x6Ad0szXp/0vFTkVzZhahi846AsrQJDkXiTeAFp3LYd/DTN8FR
         yhjiCnwA7UdbLwhHKZIYA3NoYLqH5LFeuaJyAD5gsPiBT88+/+V/0tCgqCGSuNwqx9qK
         VcbOuazmQO8d33nhBb2ib5S+dR3gm+Fjp1bhB5H86RMLbr+7ZDU7kLELt/5ePx8Cejml
         Ke3ca6ow0LTNHnw5nfhu/fQD/O8FDtzy435A6gPgeBFTNBNwVq4pJxHoT3qb5R/mxbZU
         xQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=oI4dnL3WAxnsg3J7Mkvre3vscsKD8H/LsJSI/K9G/UE=;
        b=C2tFQFebHvYThSAcCkg+WjjZqKRUkYPSt1dIgUN70iIoU5YCnTzs3E0Is02OEkWQ39
         Z9/Fb6nTiWt0G0eGx1z3Biq88w0ecvyiuP8x8CwV79iZ8Bc8PMC9ekfly62ImzsYvGt4
         4dSg51R3p8+E2Qi5HGnS3Er0yp38BDH2TK4a89zHicG3aqIeiHMMxcsUFX+H/SFWEo4U
         X1Khk93Nw54Qhu0Kjgc8m/FAGdYIhB9iHDB+kEaK0sIjwJYCNVgjdRR/vG6W/q6TLwdz
         WB5Q0QKmm19rxv9r3vqtC8qGHMY3RCzQ2lfTfcGkwrKsb5qZVSBh0hys7KhIlGNip7Ig
         wYeA==
X-Gm-Message-State: APjAAAWJWZmGW6L5IJq9elviD4H0hJaEKTHO2tz8GYGHLzlNAI14KjC3
        h1h8yvzsmv4aGTEPhptifwF8Tw==
X-Google-Smtp-Source: APXvYqyupiV6ucxUHe1cH+ONINMQAUQLA19D8AqUC48K+bYdWfiHu82bMSxqGzQZA6EKNDywt6jHoQ==
X-Received: by 2002:a17:90a:ab83:: with SMTP id n3mr7503257pjq.21.1572968374266;
        Tue, 05 Nov 2019 07:39:34 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a33sm19982929pgb.57.2019.11.05.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 07:39:34 -0800 (PST)
Date:   Tue, 5 Nov 2019 07:39:25 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Subject: Fw: [Bug 205439] New: SCTP responds to heartbeat from the wrong
 address / interface
Message-ID: <20191105073925.58ff6518@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



Begin forwarded message:

Date: Tue, 05 Nov 2019 11:59:05 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 205439] New: SCTP responds to heartbeat from the wrong addres=
s / interface


https://bugzilla.kernel.org/show_bug.cgi?id=3D205439

            Bug ID: 205439
           Summary: SCTP responds to heartbeat from the wrong address /
                    interface
           Product: Networking
           Version: 2.5
    Kernel Version: 4.9.35-server
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: paul@afk.ro
        Regression: No

Seems that SCTP responds to heartbeat from the wrong address / interface.

# netstat -nS | fgrep 162.93.39.
sctp       0      0 81.226.10.66:3561     162.93.39.198:3561      ESTABLISH=
ED
                    81.226.10.70          162.93.39.194
sctp       0      0 81.226.10.66:3560     162.93.39.134:3560      ESTABLISH=
ED
                    81.226.10.70          162.93.39.130

Bad:
    3   0.055267 162.93.39.130 =E2=86=92 185.226.110.70 SCTP 74 HEARTBEAT
    4   0.055291 81.226.10.66 =E2=86=92 162.93.39.130 SCTP 74 HEARTBEAT_ACK
    7   0.355746 162.93.39.194 =E2=86=92 185.226.110.70 SCTP 74 HEARTBEAT
    8   0.355758 81.226.10.66 =E2=86=92 162.93.39.194 SCTP 74 HEARTBEAT_ACK

Good:
   13   0.551876 162.93.39.134 =E2=86=92 81.226.10.66 SCTP 74 HEARTBEAT
   14   0.551906 81.226.10.66 =E2=86=92 162.93.39.134 SCTP 74 HEARTBEAT_ACK
   19   0.853376 162.93.39.198 =E2=86=92 81.226.10.66 SCTP 74 HEARTBEAT
   20   0.853388 81.226.10.66 =E2=86=92 162.93.39.198 SCTP 74 HEARTBEAT_ACK


This is multi-homed scenario of SCTP.

Regards,

--=20
You are receiving this mail because:
You are the assignee for the bug.
